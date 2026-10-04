# Decisions — odin-cairo

Settled choices. An entry that stops being true is rewritten, not appended to.

## 1. Generated, not hand-written

The bindings are generated with runic from the headers Amber ships, so a library bump is a
regeneration. Hand fixes are the exception and are tracked in [PATCHED.md](PATCHED.md).

## 2. Flag enums are bit_sets, chosen by a list

C flag types are `bit_set[FooBit; u32]`, so callers write `{.BACKWARD}`. `postprocess.sh` rewrites
the enums runic emits; the members of `FooBit` are bit indices, and the type keeps the C size (4
bytes) and bits, so procedures take and return it by value unchanged. The list is
`text_cluster_flags_t`, the one `*_flags_t` enum in cairo's headers (cairo has no GIR). The bit
enum is `text_cluster_flags_bit_t`, cairo's `_t` naming in place of `FooBit`. `content_t`
(`0x1000`, `0x2000`, `0x3000`) is documented as an enum, not combined, and stays one. A new GFlags
type in a header bump is added to the list by hand; generation fails if a listed enum is missing,
negative or has no single-bit member. A value rule cannot tell them from plain enums:
`antialias_t` and `operator_t` are sequential enums.

## 3. Parameters are single objects unless declared

runic 0.8 writes `[^]T` for a pointer parameter whose C name ends in `s` (`settings`, `lines`),
however many elements it holds, which lets a caller index past one element, and drops a trailing
`va_list`, binding the procedure as `#c_vararg ..any`. Amber's runic fork (branch `amber-patched`)
has `parameters: declared`: with it every procedure parameter is `^T` (`T **` is `^^T`) unless
`arrays:` in the package's `rune.yml` lists it, chosen against the C headers, and a va_list
procedure is skipped. Struct members, variables and typedefs keep runic's name guess, and the
parameters of function-pointer types are plain `^T`: a limit of the fork, true in every binding.
Where a binding needs it, the `param_rules` table in `postprocess.sh` restores the `[^]` for
those parameters' real arrays, rewrites single-object struct members and corrects `T ***` outs;
a row that matches nothing fails the build. Rejected: rewriting the output in `postprocess.sh`,
which had to be told each parameter, matched `va_list` procedures by name pattern (it deleted
`list_store_insert_with_values` for containing `_va`) and was a second place to keep in step
with the headers. `scripts/check-generated.sh` stays as the guard that any regeneration, with
any runic, keeps the listed parameters right.
