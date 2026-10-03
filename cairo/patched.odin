package cairo

// One typed pin per hand fix listed in docs/PATCHED.md: a regeneration that drops a fix
// fails to compile here.

@(private)
_pin_context_is_opaque: ^context_t = nil

@(private)
_pin_version_string: string = VERSION_STRING

@(private)
_pin_enum_members: [3]i32 = {i32(path_data_type_t.MOVE_TO), i32(text_cluster_flags_t.BACKWARD), i32(surface_observer_mode_t.NORMAL)}

@(private)
_pin_font_type_atsui: font_type_t = FONT_TYPE_ATSUI

// Byte buffers are multi-pointers, not pointers to one byte (`unsigned char *` in C).
@(private)
_pin_image_surface_get_data: proc "c" (surface: ^surface_t) -> [^]u8 = image_surface_get_data

@(private)
_pin_image_surface_create_for_data: proc "c" (data: [^]u8, format: format_t, width: i32, height: i32, stride: i32) -> ^surface_t = image_surface_create_for_data

@(private)
_pin_surface_get_mime_data: proc "c" (surface: ^surface_t, mime_type: cstring, data: ^[^]u8, length: ^u64) = surface_get_mime_data

@(private)
_pin_surface_set_mime_data: proc "c" (surface: ^surface_t, mime_type: cstring, data: [^]u8, length: u64, destroy: destroy_func_t, closure: rawptr) -> status_t = surface_set_mime_data

@(private)
_pin_write_func: write_func_t = proc "c" (closure: rawptr, data: [^]u8, length: u32) -> status_t {
    return .SUCCESS
}

@(private)
_pin_read_func: read_func_t = proc "c" (closure: rawptr, data: [^]u8, length: u32) -> status_t {
    return .SUCCESS
}

// Pointers to one object (extents, options, num_glyphs), and the run an out-parameter returns, are not multi-pointers.
@(private)
_pin_font_options_set_antialias: proc "c" (options: ^font_options_t, antialias: antialias_t) = font_options_set_antialias

@(private)
_pin_text_extents: proc "c" (cr: ^context_t, utf8: cstring, extents: ^text_extents_t) = text_extents

@(private)
_pin_scaled_font_text_to_glyphs: proc "c" (scaled_font: ^scaled_font_t, x: f64, y: f64, utf8: cstring, utf8_len: i32, glyphs: ^[^]glyph_t, num_glyphs: ^i32, clusters: ^[^]text_cluster_t, num_clusters: ^i32, cluster_flags: ^text_cluster_flags_t) -> status_t = scaled_font_text_to_glyphs

@(private)
_pin_surface_map_to_image: proc "c" (surface: ^surface_t, extents: ^rectangle_int_t) -> ^surface_t = surface_map_to_image

@(private)
_pin_recording_surface_get_extents: proc "c" (surface: ^surface_t, extents: ^rectangle_t) -> bool_t = recording_surface_get_extents

@(private)
_pin_region_get_extents: proc "c" (region: ^region_t, extents: ^rectangle_int_t) = region_get_extents

