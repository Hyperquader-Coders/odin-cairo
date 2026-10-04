#!/usr/bin/env bash
# Rewrites runic's output where runic gets Odin wrong. Run by `make generate` after runic,
# once per package: scripts/postprocess.sh cairo. Deterministic: the same runic output
# always gives the same file. Every rule is listed in docs/PATCHED.md.
# Flag enums become bit_sets (bit_sets below).
#
# Out-arrays: a `T **` that returns a run (the glyph and cluster arrays of text_to_glyphs)
# is `^[^]T`; `parameters: declared` writes `^^T` and the arrays: list cannot say `^[^]T`.
#
# Pixel and data buffers: C `unsigned char *` is a pointer to a run of bytes that callers index,
# which runic writes as `^u8`. The rules at the end of the sed list rewrite the listed
# procedures; runic 0.8 cannot (a return-type overwrite has no name to apply its multi-pointer
# detection to).
#
# The rules are odin-gtk's justfile (MIT, docs/LICENSE-odin-gtk.md).
set -euo pipefail

# The GFlags-like types. runic emits them as `enum u32` of the C values; a value rule cannot
# tell them from sequential enums, so they are listed. cairo has no GIR: the list is the
# *_flags_t enums of cairo's headers. cairo_content_t is a plain enum (its values are not
# combined) and stays one.
cairo_flags="text_cluster_flags_t"

# bit_sets <file> <strip-prefix> <enum>...: `foo_flags_t :: enum u32 {A = 1, B = 4, C = 5, NONE = 0}`
# becomes
#   foo_flags_bit_t :: enum u32 {A = 0, B = 2}  bit indices, prefix stripped from the members
#   foo_flags_t :: bit_set[foo_flags_bit_t; u32]  same size and bits as the C type
#   C :: foo_flags_t{.A, .B}                 composite masks, by their C names
#   NONE :: foo_flags_t{}                    zero members, by their C names; a name with no
#                                            underscore (NONE, FAMILY) is prefixed FOO_FLAGS_ so it is unique
# Members that are not one bit or zero are composites; a composite with a bit that has no
# member is a transmute of the C value. Fails if a listed enum is missing, has a negative
# value or has no single-bit member, so a header bump that changes a flag type is noticed.
bit_sets() {
    local file=$1 strip=$2
    shift 2
    STRIP=$strip NAMES="$*" perl -i -ne '
        BEGIN { $strip = $ENV{STRIP}; %want = map { $_ => 1 } split " ", $ENV{NAMES}; }
        if (/^(\w+) :: enum u32 \{(.*)\}\s*$/ && $want{$1}) {
            my ($name, $body) = ($1, $2);
            delete $want{$name};
            my (@bits, @zero, @comp, $all);
            (my $pre = uc($name =~ s/_t$//r)) .= "_";
            (my $bit = $name) =~ s/_t$/_bit_t/;
            for my $m (split /,\s*/, $body =~ s/\s+$//r) {
                $m =~ /^(\w+) = (-?\d+)$/ or die "postprocess: $name: cannot read member $m\n";
                my ($id, $v) = ($1, $2);
                die "postprocess: $name.$id is negative\n" if $v < 0;
                if ($v == 0) { push @zero, $id }
                elsif (($v & ($v - 1)) == 0) { push @bits, [$id, $v] }
                else { push @comp, [$id, $v] }
            }
            die "postprocess: $name has no single-bit member\n" unless @bits;
            my %idx; my $mask = 0;
            for (@bits) {
                my $i = 0; $i++ while (1 << $i) != $_->[1];
                ($id = $_->[0]) =~ s/^\Q$strip\E//;
                $idx{$_->[1]} = $id; $mask |= $_->[1];
                $_ = [$id, $i];
            }
            print "$bit :: enum u32 {", join(", ", map { "$_->[0] = $_->[1]" } @bits), "}\n";
            print "$name :: bit_set[$bit; u32]\n";
            for (@zero) { my $c = /_/ ? $_ : "$pre$_"; print "$c :: $name\{}\n" }
            for (@comp) {
                my ($id, $v) = @$_;
                $id = "$pre$id" unless $id =~ /_/;
                if (($v & ~$mask) == 0) {
                    print "$id :: $name\{", join(", ", map { ".$idx{$_}" } grep { $v & $_ } sort { $a <=> $b } keys %idx), "}\n";
                } else { print "$id :: transmute($name)u32($v)\n" }
            }
        } else { print }
        END { die "postprocess: flag enum(s) not found: " . join(" ", sort keys %want) . "\n" if %want; }
    ' "$file"
}

pkg=${1:?usage: postprocess.sh cairo}
file="$pkg/$pkg.odin"
[ -f "$file" ] || { echo "postprocess: $file not found" >&2; exit 2; }

case "$pkg" in
cairo)
    sed -i "$file" \
        -e 's/\b_CAIRO_\(PATH_\|TEXT_CLUSTER_FLAG_\|SURFACE_OBSERVER_\)//g' \
        -e '/^[A-Z_1-9]\+ :: / {s/`//g; s/\\//g; s/_CAIRO_//}' \
        -e '/^_CAIRO_/d' \
        -e 's/^VERSION_STRING :: .*/VERSION_STRING :: "1.18.0"/' \
        -e 's/^FONT_TYPE_ATSUI :: CAIRO_FONT_TYPE_QUARTZ/FONT_TYPE_ATSUI :: font_type_t.QUARTZ/' \
        -e '/^_cairo\s*::\s*/ s#.*##' \
        -e 's/^t\s*::\s*.*$/context_t :: struct #packed {}/g' \
        -e 's/\^t\b/^context_t/g' \
        -e '/^path_data_t\s*::\s*/ s#.*##' \
        -e '/^_cairo_path_data_t\s*::\s*/ s#_t##' \
        -e 's#^\([a-zA-Z][a-zA-Z_0-9]*\)_t\s*::\s*_cairo_\1$##' \
        -e 's#^_cairo_\([a-zA-Z][a-zA-Z_0-9]*\)\s*::\s*\(.*\)$#\1_t :: \2#' \
        -e '/^\(write_func_t\|read_func_t\) :: / s/\bdata: \^u8/data: [^]u8/' \
        -e '/^    \(image_surface_create_for_data\|surface_set_mime_data\) :: / s/\bdata: \^u8/data: [^]u8/' \
        -e '/^    surface_get_mime_data :: / s/\bdata: \^\^u8/data: ^[^]u8/' \
        -e '/\(user_scaled_font_text_to_glyphs_func_t\|^    scaled_font_text_to_glyphs\) :: / s/\b\(glyphs\|clusters\): \^\^/\1: ^[^]/g' \
        -e '/^    image_surface_get_data :: / s/-> \^u8/-> [^]u8/'
    # shellcheck disable=SC2086
    bit_sets "$file" "" $cairo_flags
    ;;
*)
    echo "postprocess: unknown package $pkg" >&2
    exit 2
    ;;
esac

