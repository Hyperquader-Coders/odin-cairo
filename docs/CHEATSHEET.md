# odin-cairo cheat sheet

One screen per job: the calls a program makes, in the order it makes them, and the few rules
worth remembering. The binding has several hundred declarations; this is the part a program
uses. Every name here is a public declaration in [API.md](API.md), and `make lint` fails when
one is not. Every code block is compiled against the binding before it is committed.

Conventions that hold everywhere: the `cairo_` prefix is dropped, so `cairo_fill` is
`cairo.fill`; types end in `_t`; every number is `f64` except sizes and strides, which are
`i32` (`c.int`); an out-parameter is a pointer you pass the address of; enums are named by
member, `.ARGB32`, `.OVER`. Flag sets are `bit_set`s, `{.BACKWARD}`
([PATCHED](PATCHED.md)).

## cairo:cairo — surfaces and contexts

```odin
import "cairo:cairo"
import "core:fmt"

surf := cairo.image_surface_create(.ARGB32, 320, 200)   // .RGB24 has no alpha; .A8 is a mask
defer cairo.surface_destroy(surf)                       // yours: one destroy per create
if st := cairo.surface_status(surf); st != .SUCCESS {   // creation never returns nil; it returns an error surface
	fmt.eprintln(cairo.status_to_string(st))
	return
}
cr := cairo.create(surf)                                // draws onto surf; takes its own reference
defer cairo.destroy(cr)                                 // deferred second, so it runs first
if cairo.status(cr) != .SUCCESS { return }

other := cairo.surface_create_similar(surf, .COLOR_ALPHA, 64, 64)   // a scratch surface of the same backend
defer cairo.surface_destroy(other)

loaded := cairo.image_surface_create_from_png("in.png")  // error surface on a missing file, not nil
defer cairo.surface_destroy(loaded)
if cairo.surface_write_to_png(surf, "out.png") != .SUCCESS { return }
```

| remember | |
|---|---|
| Every `create` has its own `destroy` | `surface_destroy`, `destroy` (context), `pattern_destroy`; cairo counts references, so the order is forgiving, but destroy the context first |
| Nothing returns nil on failure | check `surface_status` and `status`, and compare with `.SUCCESS` |
| `cairo.destroy` is the context's; `cairo.surface_destroy` the surface's | the unprefixed names belong to the context |
| Sizes are `i32` | convert with `c.int(w)` from an `int` |
| Never call `show_text` or `select_font_face` for real text | they are cairo's toy text API; lay text out with `pangocairo` (odin-pango) |

## cairo:cairo — drawing

```odin
import "cairo:cairo"
import "core:math"

surf := cairo.image_surface_create(.ARGB32, 320, 200)
defer cairo.surface_destroy(surf)
cr := cairo.create(surf)
defer cairo.destroy(cr)

cairo.set_source_rgba(cr, 0.1, 0.1, 0.12, 1)        // 0..1, not 0..255; the source stays until replaced
cairo.paint(cr)                                     // the whole surface
cairo.rectangle(cr, 10, 10, 100, 40)                // a path; nothing is drawn yet
cairo.fill(cr)                                      // fills it and clears the path

cairo.save(cr)                                      // pairs with restore: source, clip, transform, width
cairo.translate(cr, 160, 100)
cairo.arc(cr, 0, 0, 30, 0, 2 * math.PI)
cairo.set_source_rgb(cr, 0.9, 0.6, 0.1)
cairo.fill_preserve(cr)                             // fill, keep the path to outline it
cairo.set_line_width(cr, 2)
cairo.set_source_rgb(cr, 1, 1, 1)
cairo.stroke(cr)
cairo.restore(cr)

cairo.move_to(cr, 0, 0)                             // a line and a closed shape
cairo.line_to(cr, 50, 20)
cairo.line_to(cr, 20, 60)
cairo.close_path(cr)
cairo.new_sub_path(cr)                              // before a second arc, or it draws a joining line

grad := cairo.pattern_create_linear(0, 0, 0, 200)   // yours until destroyed; the source takes its own reference
cairo.pattern_add_color_stop_rgba(grad, 0, 1, 1, 1, 0.3)
cairo.pattern_add_color_stop_rgba(grad, 1, 0, 0, 0, 0.3)
cairo.set_source(cr, grad)
cairo.pattern_destroy(grad)
cairo.rectangle(cr, 0, 0, 320, 200)
cairo.clip(cr)                                      // ends the path; later drawing is limited to it
cairo.paint_with_alpha(cr, 0.5)

cairo.set_operator(cr, .SOURCE)                     // replace instead of blend: .CLEAR with paint erases
cairo.set_operator(cr, .OVER)                       // the default; restore it after
```

| remember | |
|---|---|
| A path is built, then consumed | `fill`, `stroke`, `clip` and `paint` use the source; `fill` and `stroke` clear the path, `_preserve` keeps it |
| `save` and `restore` come in pairs | an unbalanced `restore` sets the context to an error state |
| `set_source_rgba` colours are premultiplied by cairo, not by you | pass straight 0..1 values |
| Coordinates are between pixels | a 1-pixel line is crisp when centred on a pixel, at `x + 0.5`; on a whole number it blurs across two |

## cairo:cairo — pixels

```odin
import "cairo:cairo"

surf := cairo.image_surface_create(.ARGB32, 64, 64)
defer cairo.surface_destroy(surf)

cairo.surface_flush(surf)                                   // before touching the bytes: finish pending drawing
px := cairo.image_surface_get_data(surf)                    // [^]u8, valid until the surface is destroyed
stride := int(cairo.image_surface_get_stride(surf))         // bytes per row, not width * 4
h := int(cairo.image_surface_get_height(surf))
bytes := px[:h * stride]                                    // a slice for loops and copies

x, y := 10, 20
i := y * stride + x * 4
b, g, r, a := bytes[i], bytes[i + 1], bytes[i + 2], bytes[i + 3]   // ARGB32 is one native u32: bytes are B G R A on little-endian
bytes[i + 3] = 255                                          // premultiplied: r, g, b must not exceed a
cairo.surface_mark_dirty(surf)                              // after writing: cairo drops what it cached

row := make([]u8, 64 * 4)                                   // your own memory, wrapped without a copy
defer delete(row)
wrapped := cairo.image_surface_create_for_data(raw_data(row), .ARGB32, 64, 1, 64 * 4)
cairo.surface_destroy(wrapped)                              // destroy before the memory goes
stride2 := cairo.format_stride_for_width(.ARGB32, 64)       // the stride cairo wants for a width
```

| remember | |
|---|---|
| `image_surface_get_data` returns `[^]u8` | index it, or slice it as `px[:h * stride]`; it is [patched](PATCHED.md) from a single `^u8` |
| Use the stride, never `width * 4` | rows are padded; `format_stride_for_width` computes it |
| Flush before reading, mark dirty after writing | `surface_flush`, `surface_mark_dirty`; skip either and you read or keep stale pixels |
| Pixels are premultiplied | `.ARGB32` stores colour already multiplied by alpha; `.RGB24` leaves the top byte unused |
| A wrapped buffer outlives its surface | `image_surface_create_for_data` does not copy; destroy the surface first, then free |
