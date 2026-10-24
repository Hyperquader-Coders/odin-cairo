# Patched bindings

The bindings are generated from the C headers by runic 0.8 in Amber's fork (`../runic`, branch `amber-patched`).
Regenerating overwrites hand fixes, so each is also pinned by a typed variable in the
package's `patched.odin`: a regeneration that drops a patch fails to compile there instead
of misbehaving at run time.

To regenerate, run `make generate`; `rune.yml` and `scripts/postprocess.sh` apply the rules below.

## cairo

| Rule | Why | Pin |
|---|---|---|
| `cairo_t` becomes `context_t`, an opaque `struct #packed {}` | runic trims the prefix off `cairo_t` and leaves a type named `t` | `_pin_context_is_opaque` |
| `cairo_path_data_t` is kept as the raw union runic wrote for its anonymous members | the typedef'd alias is dropped, the struct is renamed | none: `path_data_t` is used by `path` |
| `_CAIRO_PATH_`, `_CAIRO_TEXT_CLUSTER_FLAG_`, `_CAIRO_SURFACE_OBSERVER_` prefixes are removed from enum members | the add_prefix that protects constants also lands on these members | `_pin_enum_members` |
| `VERSION_STRING` is written as the literal `"1.18.0"` | runic emits the C string concatenation `"1"".""18"".""0"`, which is not Odin | `_pin_version_string` |
| `FONT_TYPE_ATSUI` is `font_type_t.QUARTZ` | the C macro aliases an enum member by its C name | `_pin_font_type_atsui` |
| Macro constants lose their backticks and backslashes; the `_CAIRO_`-prefixed leftovers (attribute macros, `*_REPLACED_BY_*` deprecation markers) are dropped | they are not values | none |
| `text_cluster_flags_t` (`cairo_flags` in `postprocess.sh`) becomes `text_cluster_flags_bit_t :: enum u32` of bit indices plus `text_cluster_flags_t :: bit_set[text_cluster_flags_bit_t; u32]` | `{.BACKWARD}` instead of an integer; the size and bits are those of C; see DECISIONS §2 | `test_flag_bits_match_the_header` |
| Byte buffers are `[^]u8`: `image_surface_get_data` returns it; the `data` parameter of `image_surface_create_for_data`, `surface_set_mime_data`, `write_func_t` and `read_func_t` is one; `surface_get_mime_data`'s out-parameter is `^[^]u8` | C `unsigned char *` points at a run of bytes (pixels, mime data, stream chunks) that callers index; runic writes `^u8` | `_pin_image_surface_get_data`, `_pin_image_surface_create_for_data`, `_pin_surface_set_mime_data`, `_pin_surface_get_mime_data`, `_pin_write_func`, `_pin_read_func` |

runic 0.8 has a `functions: name.return` overwrite, but it writes a multi-pointer only for a
name that ends in `s`, and a return type has none, so the buffers are rewritten by name in
`postprocess.sh`. The other `unsigned char` pointers in `cairo.h` are all the buffers above.
Everything else a procedure returns or takes by pointer (`cstring`, `[^]glyph_t`, `[^]font_options_t`,
`^rectangle_int_t` ...) is unchanged.

`VERSION_STRING` is checked against the loaded library by a test, so a header bump that
leaves the literal behind fails.

## Single-object parameters

| rule | why | pin |
|---|---|---|
| `cairo/rune.yml` sets `parameters: declared`: every pointer parameter of a procedure is `^T` (`T **` is `^^T`) unless `arrays:` lists it for that procedure. The one-object `options` and `extents` (`font_options_t *`, `font_extents_t *`, `text_extents_t *`, `rectangle_t *`, `rectangle_int_t *`) and `num_glyphs`, `num_clusters`, `cluster_flags` of `scaled_font_text_to_glyphs` follow | runic writes `[^]T` for any name ending in `s`, so a caller can index past one element. Read against `cairo.h` | `_pin_font_options_set_antialias`, `_pin_text_extents`, `_pin_recording_surface_get_extents`, `_pin_region_get_extents`, `_pin_surface_map_to_image` |
| `glyphs` and `clusters` of `scaled_font_text_to_glyphs` and `user_scaled_font_text_to_glyphs_func_t` (`T **`, a run comes back) are `^[^]T`: a `postprocess.sh` rule, since `arrays:` cannot write `^[^]T` and callback types are not listed there | one out-parameter holding a run | `_pin_scaled_font_text_to_glyphs` |

Listed under `arrays:` in `rune.yml`, each a real run: `set_dash` and `get_dash` `dashes`; `glyphs` of `glyph_free`, `show_glyphs`, `show_text_glyphs`, `glyph_path` and `glyph_extents` and `scaled_font_glyph_extents`; `clusters` of `text_cluster_free` and `show_text_glyphs`; `region_create_rectangles` `rects`. The `rectangle_list_t.rectangles` field keeps runic's name heuristic (struct members are not covered by `declared`). The parameters, with the `[^]` buffers kept, are in `scripts/check-generated.sh`, run by `make lint`.

## Out-parameters (`T **`)

runic writes `[^]^T` for some `T **` parameters; an out-parameter that returns one pointer must be `^^T`. Every `[^]^T` and `^[^]^T` in the generated output was read against the headers: none is a single-pointer out-parameter, so none is rewritten (under `declared` a `T **` is `^^T` anyway). `scripts/check-generated.sh` fails on any `[^]^T` that is not in its `pointer_vectors` list, so a new one is noticed on the next `make generate`.
