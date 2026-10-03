#+test
package cairo

import "core:strings"
import "core:testing"

// Version recorded in README.md: "**Bound version:** X.Y.Z".
README :: #load("../README.md", string)

bound_version :: proc() -> (major, minor, micro: int, ok: bool) {
    marker :: "**Bound version:** "
    readme := README
    i := strings.index(readme, marker)
    if i < 0 do return
    rest := readme[i + len(marker):]
    end := strings.index_any(rest, " \n")
    if end < 0 do return
    parts := strings.split(rest[:end], ".", context.temp_allocator)
    if len(parts) != 3 do return
    nums: [3]int
    for p, n in parts {
        v := 0
        if len(p) == 0 do return
        for c in p {
            if c < '0' || c > '9' do return
            v = v * 10 + int(c - '0')
        }
        nums[n] = v
    }
    return nums[0], nums[1], nums[2], true
}

@(test)
test_readme_version_matches_header_macros :: proc(t: ^testing.T) {
    major, minor, micro, ok := bound_version()
    testing.expect(t, ok, "README.md has no '**Bound version:** X.Y.Z'")
    testing.expect_value(t, major, VERSION_MAJOR)
    testing.expect_value(t, minor, VERSION_MINOR)
    testing.expect_value(t, micro, VERSION_MICRO)
}

@(test)
test_loaded_library_matches_the_headers :: proc(t: ^testing.T) {
    testing.expect_value(t, version(), VERSION)
    testing.expect_value(t, string(version_string()), VERSION_STRING)
}

@(test)
test_draw_to_image_surface :: proc(t: ^testing.T) {
    surface := image_surface_create(.ARGB32, 8, 8)
    defer surface_destroy(surface)
    testing.expect_value(t, surface_status(surface), status_t.SUCCESS)

    cr := create(surface)
    defer destroy(cr)
    testing.expect_value(t, status(cr), status_t.SUCCESS)

    set_source_rgb(cr, 1, 0, 0)
    paint(cr)
    surface_flush(surface)

    testing.expect_value(t, image_surface_get_width(surface), 8)
    testing.expect_value(t, image_surface_get_height(surface), 8)
    pixels := image_surface_get_data(surface)
    // ARGB32 is native-endian 0xAARRGGBB: opaque red.
    px := (^u32)(pixels)^
    testing.expect_value(t, px, 0xFFFF0000)
}

// image_surface_get_data returns a [^]u8: the pixels are indexed, row by row, `stride` apart.
@(test)
test_image_surface_data_is_indexable :: proc(t: ^testing.T) {
    surface := image_surface_create(.ARGB32, 4, 3)
    defer surface_destroy(surface)
    cr := create(surface)
    defer destroy(cr)
    set_source_rgb(cr, 1, 0, 0)
    paint(cr)
    set_source_rgb(cr, 0, 0, 1)
    rectangle(cr, 1, 1, 1, 1)
    fill(cr)
    surface_flush(surface)

    pixels := image_surface_get_data(surface)
    stride := int(image_surface_get_stride(surface))
    testing.expect(t, pixels != nil)
    testing.expect(t, stride >= 4 * 4)
    // Little-endian bytes of 0xAARRGGBB are B, G, R, A.
    testing.expect_value(t, [4]u8{pixels[0], pixels[1], pixels[2], pixels[3]}, [4]u8{0, 0, 255, 255})
    at := stride + 4
    testing.expect_value(t, [4]u8{pixels[at], pixels[at + 1], pixels[at + 2], pixels[at + 3]}, [4]u8{255, 0, 0, 255})
    row := pixels[2 * stride:][:4 * 4]
    testing.expect_value(t, len(row), 16)
    testing.expect_value(t, row[2], 255)
}

// A caller-owned buffer given to create_for_data is drawn into and read back.
@(test)
test_create_for_data_draws_into_the_buffer :: proc(t: ^testing.T) {
    buf: [4 * 2 * 2]u8
    surface := image_surface_create_for_data(raw_data(buf[:]), .ARGB32, 2, 2, 8)
    defer surface_destroy(surface)
    cr := create(surface)
    defer destroy(cr)
    set_source_rgb(cr, 0, 1, 0)
    paint(cr)
    surface_flush(surface)
    testing.expect_value(t, image_surface_get_data(surface), raw_data(buf[:]))
    testing.expect_value(t, [4]u8{buf[0], buf[1], buf[2], buf[3]}, [4]u8{0, 255, 0, 255})
    testing.expect_value(t, buf[15], 255)
}

// Mime data is a byte run: set it, get it back as a [^]u8 of the given length.
@(test)
test_mime_data_round_trip :: proc(t: ^testing.T) {
    surface := image_surface_create(.ARGB32, 1, 1)
    defer surface_destroy(surface)
    @(static) payload := [3]u8{1, 2, 3}
    testing.expect_value(t, surface_set_mime_data(surface, "application/x-test", raw_data(payload[:]), 3, nil, nil), status_t.SUCCESS)
    data: [^]u8
    length: u64
    surface_get_mime_data(surface, "application/x-test", &data, &length)
    testing.expect_value(t, length, 3)
    testing.expect(t, data != nil)
    testing.expect_value(t, [3]u8{data[0], data[1], data[2]}, payload)
}

@(test)
test_status_to_string :: proc(t: ^testing.T) {
    testing.expect_value(t, string(status_to_string(.SUCCESS)), "no error has occurred")
}

// Flag enums are bit_sets of the C bits (docs/DECISIONS.md §2): the size is that of the C enum
// (4 bytes) and a member's index is the position of its bit in the header (cairo.h).

bits :: proc(s: $S) -> u32 {
    return transmute(u32)s
}

@(test)
test_flag_sets_are_the_size_of_the_c_enum :: proc(t: ^testing.T) {
    testing.expect_value(t, size_of(text_cluster_flags_t), 4)
}

@(test)
test_flag_bits_match_the_header :: proc(t: ^testing.T) {
    testing.expect_value(t, bits(text_cluster_flags_t{.BACKWARD}), 1)
}

// A `cairo_font_options_t *options` and a `cairo_text_extents_t *extents` are one object each:
// the corrected ^T parameters take a plain address.
@(test)
test_single_object_parameters :: proc(t: ^testing.T) {
    options := font_options_create()
    defer font_options_destroy(options)
    font_options_set_antialias(options, .NONE)
    testing.expect_value(t, font_options_get_antialias(options), antialias_t.NONE)

    surface := image_surface_create(.ARGB32, 64, 64)
    defer surface_destroy(surface)
    cr := create(surface)
    defer destroy(cr)
    extents: text_extents_t
    text_extents(cr, "", &extents)
    testing.expect_value(t, status(cr), status_t.SUCCESS)
    testing.expect_value(t, extents.width, 0)
}
