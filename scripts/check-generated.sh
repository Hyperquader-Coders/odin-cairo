#!/usr/bin/env bash
# Fails when one of runic 0.8's three known faults is back in the generated files. The fork
# (`parameters: declared`, skipped va_list procedures) prevents them; this proves it:
#   1. a #c_vararg procedure that stands for a C function taking a va_list (runic drops the
#      va_list and marks the procedure `#c_vararg ..any`, which is a wrong call);
#   2. a corrected parameter typed as runic wrote it (`[^]T` for a pointer to one object);
#   3. a `[^]^T` parameter (`T **` out-parameter for one pointer) that is not a listed vector.
# `scripts/check-generated.sh --list` prints the corrected parameters. Run by `make check-generated` (in `make lint`).
set -euo pipefail
cd "$(dirname "$0")/.."

# Procedures removed from the output because their C declaration takes a va_list.
removed_valist=""

# What a generic va_list procedure looks like, by its name or link_name.
valist_pattern='_valist|_va_list|vprintf|vsnprintf|vsprintf|vasprintf|_vfprintf|_logv|_vscanf'

# Corrected parameters, one per line: package, procedure (Struct.field for a struct field),
# parameter (-> for the return type), and what the type must start with:
#   ^      pointer to one object; runic wrote [^]T
#   ^^     out-parameter for one pointer (T **); runic wrote [^]^T
#   ^[^]   out-parameter for a run (T **, an array comes back); runic wrote [^]^T
#   [^]    a run (a byte buffer, a log-attr array) that runic wrote as ^T
# Every other [^] parameter whose name ends in "s" was read against the C header and is a run.
corrected() {
    cat <<'LIST'
cairo user_scaled_font_init_func_t extents ^
cairo user_scaled_font_render_glyph_func_t extents ^
cairo user_scaled_font_text_to_glyphs_func_t glyphs ^[^]
cairo user_scaled_font_text_to_glyphs_func_t num_glyphs ^
cairo user_scaled_font_text_to_glyphs_func_t clusters ^[^]
cairo user_scaled_font_text_to_glyphs_func_t num_clusters ^
cairo user_scaled_font_text_to_glyphs_func_t cluster_flags ^
cairo raster_source_acquire_func_t extents ^
cairo font_options_destroy options ^
cairo font_options_status options ^
cairo font_options_merge options ^
cairo font_options_equal options ^
cairo font_options_hash options ^
cairo font_options_set_antialias options ^
cairo font_options_get_antialias options ^
cairo font_options_set_subpixel_order options ^
cairo font_options_get_subpixel_order options ^
cairo font_options_set_hint_style options ^
cairo font_options_get_hint_style options ^
cairo font_options_set_hint_metrics options ^
cairo font_options_get_hint_metrics options ^
cairo font_options_get_variations options ^
cairo font_options_set_variations options ^
cairo font_options_set_color_mode options ^
cairo font_options_get_color_mode options ^
cairo font_options_get_color_palette options ^
cairo font_options_set_color_palette options ^
cairo font_options_set_custom_palette_color options ^
cairo font_options_get_custom_palette_color options ^
cairo set_font_options options ^
cairo get_font_options options ^
cairo text_extents extents ^
cairo glyph_extents extents ^
cairo font_extents extents ^
cairo scaled_font_create options ^
cairo scaled_font_extents extents ^
cairo scaled_font_text_extents extents ^
cairo scaled_font_glyph_extents extents ^
cairo scaled_font_text_to_glyphs glyphs ^[^]
cairo scaled_font_text_to_glyphs num_glyphs ^
cairo scaled_font_text_to_glyphs clusters ^[^]
cairo scaled_font_text_to_glyphs num_clusters ^
cairo scaled_font_text_to_glyphs cluster_flags ^
cairo scaled_font_get_font_options options ^
cairo surface_map_to_image extents ^
cairo surface_get_font_options options ^
cairo recording_surface_create extents ^
cairo recording_surface_get_extents extents ^
cairo region_get_extents extents ^
cairo image_surface_get_data -> [^]
cairo image_surface_create_for_data data [^]
cairo surface_set_mime_data data [^]
cairo surface_get_mime_data data ^[^]
cairo write_func_t data [^]
cairo read_func_t data [^]
LIST
}

if [ "${1:-}" = --list ]; then
    corrected
    exit 0
fi

fail=0

# 1. va_list procedures.
files=$(git ls-files '*.odin' | grep -Ev '(_test|/patched)\.odin$' || true)
[ -n "$files" ] || { echo "check-generated: no .odin files found" >&2; exit 2; }
# shellcheck disable=SC2086
hits=$(VALIST="$valist_pattern" REMOVED="$removed_valist" perl -ne '
    BEGIN { $re = $ENV{VALIST}; %gone = map { $_ => 1 } split " ", $ENV{REMOVED}; }
    $name = $1 if /^\s*(\w+) :: /;
    $link = $1 if /link_name = "(\w+)"/;
    if (/^\s*(\w+) :: / && $gone{$1}) { print "$ARGV:$.: $1 is a removed va_list procedure\n" }
    if (/#c_vararg/ && ($name =~ /$re/ || ($link // "") =~ /$re/)) {
        print "$ARGV:$.: $name takes a va_list and is bound as #c_vararg ..any\n" }
    $link = "" if /^\s*\w+ :: /;
    close ARGV if eof;
' $files)
if [ -n "$hits" ]; then
    echo "$hits"
    echo "check-generated: a va_list procedure must be skipped by runic; check ../runic is the amber-patched build"
    fail=1
fi

# 2. Corrected parameters.
while read -r pkg proc param want; do
    [ -n "$pkg" ] || continue
    file="$pkg/$pkg.odin"
    if ! msg=$(PROC="$proc" PARAM="$param" WANT="$want" perl -e '
        my ($proc, $param, $want) = @ENV{qw(PROC PARAM WANT)};
        my ($struct, $field) = split /\./, $proc;
        my $in = 0; my $seen = 0;
        while (<>) {
            if (defined $field) {
                $in = 1 if /^\Q$struct\E :: (?:#type )?struct/;
                if ($in && /^\}/) { $in = 0 }
                next unless $in && /^\s+\Q$field\E: (.*?),?\s*$/;
                $type = $1;
            } else {
                next unless /^\s*(?:\@\(.*?\)\s*)?\Q$proc\E :: /;
                if ($param eq "->") { next unless /-> (\S+)\s*(?:---)?\s*$/; $type = $1 }
                else { next unless /[(, ]\Q$param\E: ([^,)]+)/; $type = $1 }
            }
            $seen = 1;
            if (substr($type, 0, length $want) ne $want or ($want eq "^" and $type =~ /^\^[\[\^]/)) {
                print "$proc $param is typed $type, want $want\n"; exit 1 }
            last;
        }
        unless ($seen) { print "$proc $param not found\n"; exit 1 }
    ' "$file"); then
        echo "$file: $msg"
        fail=1
    fi
done < <(corrected | grep .)

# 3. A `[^]^T` parameter is runic's spelling of `T **`. It is right only for a counted vector of
# pointers; an out-parameter that returns one pointer is `^^T` (runic 0.8's third fault). Every
# such parameter was read against the C header; the vectors are listed here, one per line:
# procedure, parameter. A `^[^]^T` (the out-array itself) is not matched.
pointer_vectors() {
    cat <<'LIST'
LIST
}
# shellcheck disable=SC2086
vec_hits=$(VECTORS="$(pointer_vectors | grep . || true)" perl -ne '
    BEGIN { for (split /\n/, $ENV{VECTORS}) { $ok{$_} = 1 } }
    $proc = $1 if /^\s*(\w+) :: /;
    while (/(?<![\^\w])(\w+): \[\^\]\^/g) {
        print "$ARGV:$.: $proc $1 is [^]^T; use ^^T for an out-parameter, or list it in pointer_vectors if it is a counted vector\n"
            unless $ok{"$proc $1"};
    }
    close ARGV if eof;
' $files)
if [ -n "$vec_hits" ]; then
    echo "$vec_hits"
    fail=1
fi

if [ "$fail" -ne 0 ]; then
    echo "check-generated: runic's output regressed; check rune.yml (parameters: declared) and run make generate"
    exit 1
fi
echo "check-generated: OK"
