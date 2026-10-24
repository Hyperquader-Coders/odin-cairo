# odin-cairo API

Every public declaration of every package, generated from the source by `make api`; do not
edit. The reference is the [README](../README.md); the short form is the
[cheat sheet](CHEATSHEET.md).

## cairo

```text
package cairo
	constants
		COLOR_PALETTE_DEFAULT :: 0
		FONT_TYPE_ATSUI :: font_type_t.QUARTZ
		HAS_FC_FONT :: 1
		HAS_FT_FONT :: 1
		HAS_GOBJECT_FUNCTIONS :: 1
		HAS_IMAGE_SURFACE :: 1
		HAS_MIME_SURFACE :: 1
		HAS_OBSERVER_SURFACE :: 1
		HAS_PDF_SURFACE :: 1
		HAS_PNG_FUNCTIONS :: 1
		HAS_PS_SURFACE :: 1
		HAS_RECORDING_SURFACE :: 1
		HAS_SCRIPT_SURFACE :: 1
		HAS_SVG_SURFACE :: 1
		HAS_TEE_SURFACE :: 1
		HAS_USER_FONT :: 1
		HAS_XCB_SHM_FUNCTIONS :: 1
		HAS_XCB_SURFACE :: 1
		HAS_XLIB_SURFACE :: 1
		HAS_XLIB_XRENDER_SURFACE :: 1
		MIME_TYPE_CCITT_FAX :: "image/g3fax"
		MIME_TYPE_CCITT_FAX_PARAMS :: "application/x-cairo.ccitt.params"
		MIME_TYPE_EPS :: "application/postscript"
		MIME_TYPE_EPS_PARAMS :: "application/x-cairo.eps.params"
		MIME_TYPE_JBIG2 :: "application/x-cairo.jbig2"
		MIME_TYPE_JBIG2_GLOBAL :: "application/x-cairo.jbig2-global"
		MIME_TYPE_JBIG2_GLOBAL_ID :: "application/x-cairo.jbig2-global-id"
		MIME_TYPE_JP2 :: "image/jp2"
		MIME_TYPE_JPEG :: "image/jpeg"
		MIME_TYPE_PNG :: "image/png"
		MIME_TYPE_UNIQUE_ID :: "application/x-cairo.uuid"
		MIME_TYPE_URI :: "text/x-uri"
		TAG_CONTENT :: "cairo.content"
		TAG_CONTENT_REF :: "cairo.content_ref"
		TAG_DEST :: "cairo.dest"
		TAG_LINK :: "Link"
		VERSION :: ((1) * 10000) + ((18) * 100) + ((0) * 1)
		VERSION_MAJOR :: 1
		VERSION_MICRO :: 0
		VERSION_MINOR :: 18
		VERSION_STRING :: "1.18.0"

	procedures
		append_path :: proc(cr: ^context_t, path_p: ^path_t) ---
		arc :: proc(cr: ^context_t, xc: f64, yc: f64, radius: f64, angle1: f64, angle2: f64) ---
		arc_negative :: proc(cr: ^context_t, xc: f64, yc: f64, radius: f64, angle1: f64, angle2: f64) ---
		clip :: proc(cr: ^context_t) ---
		clip_extents :: proc(cr: ^context_t, x1: ^f64, y1: ^f64, x2: ^f64, y2: ^f64) ---
		clip_preserve :: proc(cr: ^context_t) ---
		close_path :: proc(cr: ^context_t) ---
		copy_clip_rectangle_list :: proc(cr: ^context_t) -> ^rectangle_list_t ---
		copy_page :: proc(cr: ^context_t) ---
		copy_path :: proc(cr: ^context_t) -> ^path_t ---
		copy_path_flat :: proc(cr: ^context_t) -> ^path_t ---
		create :: proc(target: ^surface_t) -> ^context_t ---
		curve_to :: proc(cr: ^context_t, x1: f64, y1: f64, x2: f64, y2: f64, x3: f64, y3: f64) ---
		debug_reset_static_data :: proc() ---
		destroy :: proc(cr: ^context_t) ---
		device_acquire :: proc(device: ^device_t) -> status_t ---
		device_destroy :: proc(device: ^device_t) ---
		device_finish :: proc(device: ^device_t) ---
		device_flush :: proc(device: ^device_t) ---
		device_get_reference_count :: proc(device: ^device_t) -> u32 ---
		device_get_type :: proc(device: ^device_t) -> device_type_t ---
		device_get_user_data :: proc(device: ^device_t, key: ^user_data_key_t) -> rawptr ---
		device_observer_elapsed :: proc(abstract_device: ^device_t) -> f64 ---
		device_observer_fill_elapsed :: proc(abstract_device: ^device_t) -> f64 ---
		device_observer_glyphs_elapsed :: proc(abstract_device: ^device_t) -> f64 ---
		device_observer_mask_elapsed :: proc(abstract_device: ^device_t) -> f64 ---
		device_observer_paint_elapsed :: proc(abstract_device: ^device_t) -> f64 ---
		device_observer_print :: proc(abstract_device: ^device_t, write_func: write_func_t, closure: rawptr) -> status_t ---
		device_observer_stroke_elapsed :: proc(abstract_device: ^device_t) -> f64 ---
		device_reference :: proc(device: ^device_t) -> ^device_t ---
		device_release :: proc(device: ^device_t) ---
		device_set_user_data :: proc(device: ^device_t, key: ^user_data_key_t, user_data: rawptr, destroy: destroy_func_t) -> status_t ---
		device_status :: proc(device: ^device_t) -> status_t ---
		device_to_user :: proc(cr: ^context_t, x: ^f64, y: ^f64) ---
		device_to_user_distance :: proc(cr: ^context_t, dx: ^f64, dy: ^f64) ---
		fill :: proc(cr: ^context_t) ---
		fill_extents :: proc(cr: ^context_t, x1: ^f64, y1: ^f64, x2: ^f64, y2: ^f64) ---
		fill_preserve :: proc(cr: ^context_t) ---
		font_extents :: proc(cr: ^context_t, extents: ^font_extents_t) ---
		font_face_destroy :: proc(font_face: ^font_face_t) ---
		font_face_get_reference_count :: proc(font_face: ^font_face_t) -> u32 ---
		font_face_get_type :: proc(font_face: ^font_face_t) -> font_type_t ---
		font_face_get_user_data :: proc(font_face: ^font_face_t, key: ^user_data_key_t) -> rawptr ---
		font_face_reference :: proc(font_face: ^font_face_t) -> ^font_face_t ---
		font_face_set_user_data :: proc(font_face: ^font_face_t, key: ^user_data_key_t, user_data: rawptr, destroy: destroy_func_t) -> status_t ---
		font_face_status :: proc(font_face: ^font_face_t) -> status_t ---
		font_options_copy :: proc(original: ^font_options_t) -> ^font_options_t ---
		font_options_create :: proc() -> ^font_options_t ---
		font_options_destroy :: proc(options: ^font_options_t) ---
		font_options_equal :: proc(options: ^font_options_t, other: ^font_options_t) -> bool_t ---
		font_options_get_antialias :: proc(options: ^font_options_t) -> antialias_t ---
		font_options_get_color_mode :: proc(options: ^font_options_t) -> color_mode_t ---
		font_options_get_color_palette :: proc(options: ^font_options_t) -> u32 ---
		font_options_get_custom_palette_color :: proc(options: ^font_options_t, index: u32, red: ^f64, green: ^f64, blue: ^f64, alpha: ^f64) -> status_t ---
		font_options_get_hint_metrics :: proc(options: ^font_options_t) -> hint_metrics_t ---
		font_options_get_hint_style :: proc(options: ^font_options_t) -> hint_style_t ---
		font_options_get_subpixel_order :: proc(options: ^font_options_t) -> subpixel_order_t ---
		font_options_get_variations :: proc(options: ^font_options_t) -> cstring ---
		font_options_hash :: proc(options: ^font_options_t) -> u64 ---
		font_options_merge :: proc(options: ^font_options_t, other: ^font_options_t) ---
		font_options_set_antialias :: proc(options: ^font_options_t, antialias: antialias_t) ---
		font_options_set_color_mode :: proc(options: ^font_options_t, color_mode: color_mode_t) ---
		font_options_set_color_palette :: proc(options: ^font_options_t, palette_index: u32) ---
		font_options_set_custom_palette_color :: proc(options: ^font_options_t, index: u32, red: f64, green: f64, blue: f64, alpha: f64) ---
		font_options_set_hint_metrics :: proc(options: ^font_options_t, hint_metrics: hint_metrics_t) ---
		font_options_set_hint_style :: proc(options: ^font_options_t, hint_style: hint_style_t) ---
		font_options_set_subpixel_order :: proc(options: ^font_options_t, subpixel_order: subpixel_order_t) ---
		font_options_set_variations :: proc(options: ^font_options_t, variations: cstring) ---
		font_options_status :: proc(options: ^font_options_t) -> status_t ---
		format_stride_for_width :: proc(format: format_t, width: i32) -> i32 ---
		get_antialias :: proc(cr: ^context_t) -> antialias_t ---
		get_current_point :: proc(cr: ^context_t, x: ^f64, y: ^f64) ---
		get_dash :: proc(cr: ^context_t, dashes: [^]f64, offset: ^f64) ---
		get_dash_count :: proc(cr: ^context_t) -> i32 ---
		get_fill_rule :: proc(cr: ^context_t) -> fill_rule_t ---
		get_font_face :: proc(cr: ^context_t) -> ^font_face_t ---
		get_font_matrix :: proc(cr: ^context_t, matrix_p: ^matrix_t) ---
		get_font_options :: proc(cr: ^context_t, options: ^font_options_t) ---
		get_group_target :: proc(cr: ^context_t) -> ^surface_t ---
		get_hairline :: proc(cr: ^context_t) -> bool_t ---
		get_line_cap :: proc(cr: ^context_t) -> line_cap_t ---
		get_line_join :: proc(cr: ^context_t) -> line_join_t ---
		get_line_width :: proc(cr: ^context_t) -> f64 ---
		get_matrix :: proc(cr: ^context_t, matrix_p: ^matrix_t) ---
		get_miter_limit :: proc(cr: ^context_t) -> f64 ---
		get_operator :: proc(cr: ^context_t) -> operator_t ---
		get_reference_count :: proc(cr: ^context_t) -> u32 ---
		get_scaled_font :: proc(cr: ^context_t) -> ^scaled_font_t ---
		get_source :: proc(cr: ^context_t) -> ^pattern_t ---
		get_target :: proc(cr: ^context_t) -> ^surface_t ---
		get_tolerance :: proc(cr: ^context_t) -> f64 ---
		get_user_data :: proc(cr: ^context_t, key: ^user_data_key_t) -> rawptr ---
		glyph_allocate :: proc(num_glyphs: i32) -> ^glyph_t ---
		glyph_extents :: proc(cr: ^context_t, glyphs: [^]glyph_t, num_glyphs: i32, extents: ^text_extents_t) ---
		glyph_free :: proc(glyphs: [^]glyph_t) ---
		glyph_path :: proc(cr: ^context_t, glyphs: [^]glyph_t, num_glyphs: i32) ---
		has_current_point :: proc(cr: ^context_t) -> bool_t ---
		identity_matrix :: proc(cr: ^context_t) ---
		image_surface_create :: proc(format: format_t, width: i32, height: i32) -> ^surface_t ---
		image_surface_create_for_data :: proc(data: [^]u8, format: format_t, width: i32, height: i32, stride: i32) -> ^surface_t ---
		image_surface_create_from_png :: proc(filename: cstring) -> ^surface_t ---
		image_surface_create_from_png_stream :: proc(read_func: read_func_t, closure: rawptr) -> ^surface_t ---
		image_surface_get_data :: proc(surface: ^surface_t) -> [^]u8 ---
		image_surface_get_format :: proc(surface: ^surface_t) -> format_t ---
		image_surface_get_height :: proc(surface: ^surface_t) -> i32 ---
		image_surface_get_stride :: proc(surface: ^surface_t) -> i32 ---
		image_surface_get_width :: proc(surface: ^surface_t) -> i32 ---
		in_clip :: proc(cr: ^context_t, x: f64, y: f64) -> bool_t ---
		in_fill :: proc(cr: ^context_t, x: f64, y: f64) -> bool_t ---
		in_stroke :: proc(cr: ^context_t, x: f64, y: f64) -> bool_t ---
		line_to :: proc(cr: ^context_t, x: f64, y: f64) ---
		mask :: proc(cr: ^context_t, pattern: ^pattern_t) ---
		mask_surface :: proc(cr: ^context_t, surface: ^surface_t, surface_x: f64, surface_y: f64) ---
		matrix_init :: proc(matrix_p: ^matrix_t, xx: f64, yx: f64, xy: f64, yy: f64, x0: f64, y0: f64) ---
		matrix_init_identity :: proc(matrix_p: ^matrix_t) ---
		matrix_init_rotate :: proc(matrix_p: ^matrix_t, radians: f64) ---
		matrix_init_scale :: proc(matrix_p: ^matrix_t, sx: f64, sy: f64) ---
		matrix_init_translate :: proc(matrix_p: ^matrix_t, tx: f64, ty: f64) ---
		matrix_invert :: proc(matrix_p: ^matrix_t) -> status_t ---
		matrix_multiply :: proc(result: ^matrix_t, a: ^matrix_t, b: ^matrix_t) ---
		matrix_rotate :: proc(matrix_p: ^matrix_t, radians: f64) ---
		matrix_scale :: proc(matrix_p: ^matrix_t, sx: f64, sy: f64) ---
		matrix_transform_distance :: proc(matrix_p: ^matrix_t, dx: ^f64, dy: ^f64) ---
		matrix_transform_point :: proc(matrix_p: ^matrix_t, x: ^f64, y: ^f64) ---
		matrix_translate :: proc(matrix_p: ^matrix_t, tx: f64, ty: f64) ---
		mesh_pattern_begin_patch :: proc(pattern: ^pattern_t) ---
		mesh_pattern_curve_to :: proc(pattern: ^pattern_t, x1: f64, y1: f64, x2: f64, y2: f64, x3: f64, y3: f64) ---
		mesh_pattern_end_patch :: proc(pattern: ^pattern_t) ---
		mesh_pattern_get_control_point :: proc(pattern: ^pattern_t, patch_num: u32, point_num: u32, x: ^f64, y: ^f64) -> status_t ---
		mesh_pattern_get_corner_color_rgba :: proc(pattern: ^pattern_t, patch_num: u32, corner_num: u32, red: ^f64, green: ^f64, blue: ^f64, alpha: ^f64) -> status_t ---
		mesh_pattern_get_patch_count :: proc(pattern: ^pattern_t, count: ^u32) -> status_t ---
		mesh_pattern_get_path :: proc(pattern: ^pattern_t, patch_num: u32) -> ^path_t ---
		mesh_pattern_line_to :: proc(pattern: ^pattern_t, x: f64, y: f64) ---
		mesh_pattern_move_to :: proc(pattern: ^pattern_t, x: f64, y: f64) ---
		mesh_pattern_set_control_point :: proc(pattern: ^pattern_t, point_num: u32, x: f64, y: f64) ---
		mesh_pattern_set_corner_color_rgb :: proc(pattern: ^pattern_t, corner_num: u32, red: f64, green: f64, blue: f64) ---
		mesh_pattern_set_corner_color_rgba :: proc(pattern: ^pattern_t, corner_num: u32, red: f64, green: f64, blue: f64, alpha: f64) ---
		move_to :: proc(cr: ^context_t, x: f64, y: f64) ---
		new_path :: proc(cr: ^context_t) ---
		new_sub_path :: proc(cr: ^context_t) ---
		paint :: proc(cr: ^context_t) ---
		paint_with_alpha :: proc(cr: ^context_t, alpha: f64) ---
		path_destroy :: proc(path_p: ^path_t) ---
		path_extents :: proc(cr: ^context_t, x1: ^f64, y1: ^f64, x2: ^f64, y2: ^f64) ---
		pattern_add_color_stop_rgb :: proc(pattern: ^pattern_t, offset: f64, red: f64, green: f64, blue: f64) ---
		pattern_add_color_stop_rgba :: proc(pattern: ^pattern_t, offset: f64, red: f64, green: f64, blue: f64, alpha: f64) ---
		pattern_create_for_surface :: proc(surface: ^surface_t) -> ^pattern_t ---
		pattern_create_linear :: proc(x0: f64, y0: f64, x1: f64, y1: f64) -> ^pattern_t ---
		pattern_create_mesh :: proc() -> ^pattern_t ---
		pattern_create_radial :: proc(cx0: f64, cy0: f64, radius0: f64, cx1: f64, cy1: f64, radius1: f64) -> ^pattern_t ---
		pattern_create_raster_source :: proc(user_data: rawptr, content: content_t, width: i32, height: i32) -> ^pattern_t ---
		pattern_create_rgb :: proc(red: f64, green: f64, blue: f64) -> ^pattern_t ---
		pattern_create_rgba :: proc(red: f64, green: f64, blue: f64, alpha: f64) -> ^pattern_t ---
		pattern_destroy :: proc(pattern: ^pattern_t) ---
		pattern_get_color_stop_count :: proc(pattern: ^pattern_t, count: ^i32) -> status_t ---
		pattern_get_color_stop_rgba :: proc(pattern: ^pattern_t, index: i32, offset: ^f64, red: ^f64, green: ^f64, blue: ^f64, alpha: ^f64) -> status_t ---
		pattern_get_dither :: proc(pattern: ^pattern_t) -> dither_t ---
		pattern_get_extend :: proc(pattern: ^pattern_t) -> extend_t ---
		pattern_get_filter :: proc(pattern: ^pattern_t) -> filter_t ---
		pattern_get_linear_points :: proc(pattern: ^pattern_t, x0: ^f64, y0: ^f64, x1: ^f64, y1: ^f64) -> status_t ---
		pattern_get_matrix :: proc(pattern: ^pattern_t, matrix_p: ^matrix_t) ---
		pattern_get_radial_circles :: proc(pattern: ^pattern_t, x0: ^f64, y0: ^f64, r0: ^f64, x1: ^f64, y1: ^f64, r1: ^f64) -> status_t ---
		pattern_get_reference_count :: proc(pattern: ^pattern_t) -> u32 ---
		pattern_get_rgba :: proc(pattern: ^pattern_t, red: ^f64, green: ^f64, blue: ^f64, alpha: ^f64) -> status_t ---
		pattern_get_surface :: proc(pattern: ^pattern_t, surface: ^^surface_t) -> status_t ---
		pattern_get_type :: proc(pattern: ^pattern_t) -> pattern_type_t ---
		pattern_get_user_data :: proc(pattern: ^pattern_t, key: ^user_data_key_t) -> rawptr ---
		pattern_reference :: proc(pattern: ^pattern_t) -> ^pattern_t ---
		pattern_set_dither :: proc(pattern: ^pattern_t, dither: dither_t) ---
		pattern_set_extend :: proc(pattern: ^pattern_t, extend: extend_t) ---
		pattern_set_filter :: proc(pattern: ^pattern_t, filter: filter_t) ---
		pattern_set_matrix :: proc(pattern: ^pattern_t, matrix_p: ^matrix_t) ---
		pattern_set_user_data :: proc(pattern: ^pattern_t, key: ^user_data_key_t, user_data: rawptr, destroy: destroy_func_t) -> status_t ---
		pattern_status :: proc(pattern: ^pattern_t) -> status_t ---
		pop_group :: proc(cr: ^context_t) -> ^pattern_t ---
		pop_group_to_source :: proc(cr: ^context_t) ---
		push_group :: proc(cr: ^context_t) ---
		push_group_with_content :: proc(cr: ^context_t, content: content_t) ---
		raster_source_pattern_get_acquire :: proc(pattern: ^pattern_t, acquire: ^raster_source_acquire_func_t, release: ^raster_source_release_func_t) ---
		raster_source_pattern_get_callback_data :: proc(pattern: ^pattern_t) -> rawptr ---
		raster_source_pattern_get_copy :: proc(pattern: ^pattern_t) -> raster_source_copy_func_t ---
		raster_source_pattern_get_finish :: proc(pattern: ^pattern_t) -> raster_source_finish_func_t ---
		raster_source_pattern_get_snapshot :: proc(pattern: ^pattern_t) -> raster_source_snapshot_func_t ---
		raster_source_pattern_set_acquire :: proc(pattern: ^pattern_t, acquire: raster_source_acquire_func_t, release: raster_source_release_func_t) ---
		raster_source_pattern_set_callback_data :: proc(pattern: ^pattern_t, data: rawptr) ---
		raster_source_pattern_set_copy :: proc(pattern: ^pattern_t, copy: raster_source_copy_func_t) ---
		raster_source_pattern_set_finish :: proc(pattern: ^pattern_t, finish: raster_source_finish_func_t) ---
		raster_source_pattern_set_snapshot :: proc(pattern: ^pattern_t, snapshot: raster_source_snapshot_func_t) ---
		recording_surface_create :: proc(content: content_t, extents: ^rectangle_t) -> ^surface_t ---
		recording_surface_get_extents :: proc(surface: ^surface_t, extents: ^rectangle_t) -> bool_t ---
		recording_surface_ink_extents :: proc(surface: ^surface_t, x0: ^f64, y0: ^f64, width: ^f64, height: ^f64) ---
		rectangle :: proc(cr: ^context_t, x: f64, y: f64, width: f64, height: f64) ---
		rectangle_list_destroy :: proc(rectangle_list: ^rectangle_list_t) ---
		reference :: proc(cr: ^context_t) -> ^context_t ---
		region_contains_point :: proc(region: ^region_t, x: i32, y: i32) -> bool_t ---
		region_contains_rectangle :: proc(region: ^region_t, rectangle: ^rectangle_int_t) -> region_overlap_t ---
		region_copy :: proc(original: ^region_t) -> ^region_t ---
		region_create :: proc() -> ^region_t ---
		region_create_rectangle :: proc(rectangle: ^rectangle_int_t) -> ^region_t ---
		region_create_rectangles :: proc(rects: [^]rectangle_int_t, count: i32) -> ^region_t ---
		region_destroy :: proc(region: ^region_t) ---
		region_equal :: proc(a: ^region_t, b: ^region_t) -> bool_t ---
		region_get_extents :: proc(region: ^region_t, extents: ^rectangle_int_t) ---
		region_get_rectangle :: proc(region: ^region_t, nth: i32, rectangle: ^rectangle_int_t) ---
		region_intersect :: proc(dst: ^region_t, other: ^region_t) -> status_t ---
		region_intersect_rectangle :: proc(dst: ^region_t, rectangle: ^rectangle_int_t) -> status_t ---
		region_is_empty :: proc(region: ^region_t) -> bool_t ---
		region_num_rectangles :: proc(region: ^region_t) -> i32 ---
		region_reference :: proc(region: ^region_t) -> ^region_t ---
		region_status :: proc(region: ^region_t) -> status_t ---
		region_subtract :: proc(dst: ^region_t, other: ^region_t) -> status_t ---
		region_subtract_rectangle :: proc(dst: ^region_t, rectangle: ^rectangle_int_t) -> status_t ---
		region_translate :: proc(region: ^region_t, dx: i32, dy: i32) ---
		region_union :: proc(dst: ^region_t, other: ^region_t) -> status_t ---
		region_union_rectangle :: proc(dst: ^region_t, rectangle: ^rectangle_int_t) -> status_t ---
		region_xor :: proc(dst: ^region_t, other: ^region_t) -> status_t ---
		region_xor_rectangle :: proc(dst: ^region_t, rectangle: ^rectangle_int_t) -> status_t ---
		rel_curve_to :: proc(cr: ^context_t, dx1: f64, dy1: f64, dx2: f64, dy2: f64, dx3: f64, dy3: f64) ---
		rel_line_to :: proc(cr: ^context_t, dx: f64, dy: f64) ---
		rel_move_to :: proc(cr: ^context_t, dx: f64, dy: f64) ---
		reset_clip :: proc(cr: ^context_t) ---
		restore :: proc(cr: ^context_t) ---
		rotate :: proc(cr: ^context_t, angle: f64) ---
		save :: proc(cr: ^context_t) ---
		scale :: proc(cr: ^context_t, sx: f64, sy: f64) ---
		scaled_font_create :: proc(font_face: ^font_face_t, font_matrix: ^matrix_t, ctm: ^matrix_t, options: ^font_options_t) -> ^scaled_font_t ---
		scaled_font_destroy :: proc(scaled_font: ^scaled_font_t) ---
		scaled_font_extents :: proc(scaled_font: ^scaled_font_t, extents: ^font_extents_t) ---
		scaled_font_get_ctm :: proc(scaled_font: ^scaled_font_t, ctm: ^matrix_t) ---
		scaled_font_get_font_face :: proc(scaled_font: ^scaled_font_t) -> ^font_face_t ---
		scaled_font_get_font_matrix :: proc(scaled_font: ^scaled_font_t, font_matrix: ^matrix_t) ---
		scaled_font_get_font_options :: proc(scaled_font: ^scaled_font_t, options: ^font_options_t) ---
		scaled_font_get_reference_count :: proc(scaled_font: ^scaled_font_t) -> u32 ---
		scaled_font_get_scale_matrix :: proc(scaled_font: ^scaled_font_t, scale_matrix: ^matrix_t) ---
		scaled_font_get_type :: proc(scaled_font: ^scaled_font_t) -> font_type_t ---
		scaled_font_get_user_data :: proc(scaled_font: ^scaled_font_t, key: ^user_data_key_t) -> rawptr ---
		scaled_font_glyph_extents :: proc(scaled_font: ^scaled_font_t, glyphs: [^]glyph_t, num_glyphs: i32, extents: ^text_extents_t) ---
		scaled_font_reference :: proc(scaled_font: ^scaled_font_t) -> ^scaled_font_t ---
		scaled_font_set_user_data :: proc(scaled_font: ^scaled_font_t, key: ^user_data_key_t, user_data: rawptr, destroy: destroy_func_t) -> status_t ---
		scaled_font_status :: proc(scaled_font: ^scaled_font_t) -> status_t ---
		scaled_font_text_extents :: proc(scaled_font: ^scaled_font_t, utf8: cstring, extents: ^text_extents_t) ---
		scaled_font_text_to_glyphs :: proc(scaled_font: ^scaled_font_t, x: f64, y: f64, utf8: cstring, utf8_len: i32, glyphs: ^[^]glyph_t, num_glyphs: ^i32, clusters: ^[^]text_cluster_t, num_clusters: ^i32, cluster_flags: ^text_cluster_flags_t) -> status_t ---
		select_font_face :: proc(cr: ^context_t, family: cstring, slant: font_slant_t, weight: font_weight_t) ---
		set_antialias :: proc(cr: ^context_t, antialias: antialias_t) ---
		set_dash :: proc(cr: ^context_t, dashes: [^]f64, num_dashes: i32, offset: f64) ---
		set_fill_rule :: proc(cr: ^context_t, fill_rule: fill_rule_t) ---
		set_font_face :: proc(cr: ^context_t, font_face: ^font_face_t) ---
		set_font_matrix :: proc(cr: ^context_t, matrix_p: ^matrix_t) ---
		set_font_options :: proc(cr: ^context_t, options: ^font_options_t) ---
		set_font_size :: proc(cr: ^context_t, size: f64) ---
		set_hairline :: proc(cr: ^context_t, set_hairline: bool_t) ---
		set_line_cap :: proc(cr: ^context_t, line_cap: line_cap_t) ---
		set_line_join :: proc(cr: ^context_t, line_join: line_join_t) ---
		set_line_width :: proc(cr: ^context_t, width: f64) ---
		set_matrix :: proc(cr: ^context_t, matrix_p: ^matrix_t) ---
		set_miter_limit :: proc(cr: ^context_t, limit: f64) ---
		set_operator :: proc(cr: ^context_t, op: operator_t) ---
		set_scaled_font :: proc(cr: ^context_t, scaled_font: ^scaled_font_t) ---
		set_source :: proc(cr: ^context_t, source: ^pattern_t) ---
		set_source_rgb :: proc(cr: ^context_t, red: f64, green: f64, blue: f64) ---
		set_source_rgba :: proc(cr: ^context_t, red: f64, green: f64, blue: f64, alpha: f64) ---
		set_source_surface :: proc(cr: ^context_t, surface: ^surface_t, x: f64, y: f64) ---
		set_tolerance :: proc(cr: ^context_t, tolerance: f64) ---
		set_user_data :: proc(cr: ^context_t, key: ^user_data_key_t, user_data: rawptr, destroy: destroy_func_t) -> status_t ---
		show_glyphs :: proc(cr: ^context_t, glyphs: [^]glyph_t, num_glyphs: i32) ---
		show_page :: proc(cr: ^context_t) ---
		show_text :: proc(cr: ^context_t, utf8: cstring) ---
		show_text_glyphs :: proc(cr: ^context_t, utf8: cstring, utf8_len: i32, glyphs: [^]glyph_t, num_glyphs: i32, clusters: [^]text_cluster_t, num_clusters: i32, cluster_flags: text_cluster_flags_t) ---
		status :: proc(cr: ^context_t) -> status_t ---
		status_to_string :: proc(status: status_t) -> cstring ---
		stroke :: proc(cr: ^context_t) ---
		stroke_extents :: proc(cr: ^context_t, x1: ^f64, y1: ^f64, x2: ^f64, y2: ^f64) ---
		stroke_preserve :: proc(cr: ^context_t) ---
		surface_copy_page :: proc(surface: ^surface_t) ---
		surface_create_for_rectangle :: proc(target: ^surface_t, x: f64, y: f64, width: f64, height: f64) -> ^surface_t ---
		surface_create_observer :: proc(target: ^surface_t, mode: surface_observer_mode_t) -> ^surface_t ---
		surface_create_similar :: proc(other: ^surface_t, content: content_t, width: i32, height: i32) -> ^surface_t ---
		surface_create_similar_image :: proc(other: ^surface_t, format: format_t, width: i32, height: i32) -> ^surface_t ---
		surface_destroy :: proc(surface: ^surface_t) ---
		surface_finish :: proc(surface: ^surface_t) ---
		surface_flush :: proc(surface: ^surface_t) ---
		surface_get_content :: proc(surface: ^surface_t) -> content_t ---
		surface_get_device :: proc(surface: ^surface_t) -> ^device_t ---
		surface_get_device_offset :: proc(surface: ^surface_t, x_offset: ^f64, y_offset: ^f64) ---
		surface_get_device_scale :: proc(surface: ^surface_t, x_scale: ^f64, y_scale: ^f64) ---
		surface_get_fallback_resolution :: proc(surface: ^surface_t, x_pixels_per_inch: ^f64, y_pixels_per_inch: ^f64) ---
		surface_get_font_options :: proc(surface: ^surface_t, options: ^font_options_t) ---
		surface_get_mime_data :: proc(surface: ^surface_t, mime_type: cstring, data: ^[^]u8, length: ^u64) ---
		surface_get_reference_count :: proc(surface: ^surface_t) -> u32 ---
		surface_get_type :: proc(surface: ^surface_t) -> surface_type_t ---
		surface_get_user_data :: proc(surface: ^surface_t, key: ^user_data_key_t) -> rawptr ---
		surface_has_show_text_glyphs :: proc(surface: ^surface_t) -> bool_t ---
		surface_map_to_image :: proc(surface: ^surface_t, extents: ^rectangle_int_t) -> ^surface_t ---
		surface_mark_dirty :: proc(surface: ^surface_t) ---
		surface_mark_dirty_rectangle :: proc(surface: ^surface_t, x: i32, y: i32, width: i32, height: i32) ---
		surface_observer_add_fill_callback :: proc(abstract_surface: ^surface_t, func: surface_observer_callback_t, data: rawptr) -> status_t ---
		surface_observer_add_finish_callback :: proc(abstract_surface: ^surface_t, func: surface_observer_callback_t, data: rawptr) -> status_t ---
		surface_observer_add_flush_callback :: proc(abstract_surface: ^surface_t, func: surface_observer_callback_t, data: rawptr) -> status_t ---
		surface_observer_add_glyphs_callback :: proc(abstract_surface: ^surface_t, func: surface_observer_callback_t, data: rawptr) -> status_t ---
		surface_observer_add_mask_callback :: proc(abstract_surface: ^surface_t, func: surface_observer_callback_t, data: rawptr) -> status_t ---
		surface_observer_add_paint_callback :: proc(abstract_surface: ^surface_t, func: surface_observer_callback_t, data: rawptr) -> status_t ---
		surface_observer_add_stroke_callback :: proc(abstract_surface: ^surface_t, func: surface_observer_callback_t, data: rawptr) -> status_t ---
		surface_observer_elapsed :: proc(abstract_surface: ^surface_t) -> f64 ---
		surface_observer_print :: proc(abstract_surface: ^surface_t, write_func: write_func_t, closure: rawptr) -> status_t ---
		surface_reference :: proc(surface: ^surface_t) -> ^surface_t ---
		surface_set_device_offset :: proc(surface: ^surface_t, x_offset: f64, y_offset: f64) ---
		surface_set_device_scale :: proc(surface: ^surface_t, x_scale: f64, y_scale: f64) ---
		surface_set_fallback_resolution :: proc(surface: ^surface_t, x_pixels_per_inch: f64, y_pixels_per_inch: f64) ---
		surface_set_mime_data :: proc(surface: ^surface_t, mime_type: cstring, data: [^]u8, length: u64, destroy: destroy_func_t, closure: rawptr) -> status_t ---
		surface_set_user_data :: proc(surface: ^surface_t, key: ^user_data_key_t, user_data: rawptr, destroy: destroy_func_t) -> status_t ---
		surface_show_page :: proc(surface: ^surface_t) ---
		surface_status :: proc(surface: ^surface_t) -> status_t ---
		surface_supports_mime_type :: proc(surface: ^surface_t, mime_type: cstring) -> bool_t ---
		surface_unmap_image :: proc(surface: ^surface_t, image: ^surface_t) ---
		surface_write_to_png :: proc(surface: ^surface_t, filename: cstring) -> status_t ---
		surface_write_to_png_stream :: proc(surface: ^surface_t, write_func: write_func_t, closure: rawptr) -> status_t ---
		tag_begin :: proc(cr: ^context_t, tag_name: cstring, attributes: cstring) ---
		tag_end :: proc(cr: ^context_t, tag_name: cstring) ---
		text_cluster_allocate :: proc(num_clusters: i32) -> ^text_cluster_t ---
		text_cluster_free :: proc(clusters: [^]text_cluster_t) ---
		text_extents :: proc(cr: ^context_t, utf8: cstring, extents: ^text_extents_t) ---
		text_path :: proc(cr: ^context_t, utf8: cstring) ---
		toy_font_face_create :: proc(family: cstring, slant: font_slant_t, weight: font_weight_t) -> ^font_face_t ---
		toy_font_face_get_family :: proc(font_face: ^font_face_t) -> cstring ---
		toy_font_face_get_slant :: proc(font_face: ^font_face_t) -> font_slant_t ---
		toy_font_face_get_weight :: proc(font_face: ^font_face_t) -> font_weight_t ---
		transform :: proc(cr: ^context_t, matrix_p: ^matrix_t) ---
		translate :: proc(cr: ^context_t, tx: f64, ty: f64) ---
		user_font_face_create :: proc() -> ^font_face_t ---
		user_font_face_get_init_func :: proc(font_face: ^font_face_t) -> user_scaled_font_init_func_t ---
		user_font_face_get_render_color_glyph_func :: proc(font_face: ^font_face_t) -> user_scaled_font_render_glyph_func_t ---
		user_font_face_get_render_glyph_func :: proc(font_face: ^font_face_t) -> user_scaled_font_render_glyph_func_t ---
		user_font_face_get_text_to_glyphs_func :: proc(font_face: ^font_face_t) -> user_scaled_font_text_to_glyphs_func_t ---
		user_font_face_get_unicode_to_glyph_func :: proc(font_face: ^font_face_t) -> user_scaled_font_unicode_to_glyph_func_t ---
		user_font_face_set_init_func :: proc(font_face: ^font_face_t, init_func: user_scaled_font_init_func_t) ---
		user_font_face_set_render_color_glyph_func :: proc(font_face: ^font_face_t, render_glyph_func: user_scaled_font_render_glyph_func_t) ---
		user_font_face_set_render_glyph_func :: proc(font_face: ^font_face_t, render_glyph_func: user_scaled_font_render_glyph_func_t) ---
		user_font_face_set_text_to_glyphs_func :: proc(font_face: ^font_face_t, text_to_glyphs_func: user_scaled_font_text_to_glyphs_func_t) ---
		user_font_face_set_unicode_to_glyph_func :: proc(font_face: ^font_face_t, unicode_to_glyph_func: user_scaled_font_unicode_to_glyph_func_t) ---
		user_scaled_font_get_foreground_marker :: proc(scaled_font: ^scaled_font_t) -> ^pattern_t ---
		user_scaled_font_get_foreground_source :: proc(scaled_font: ^scaled_font_t) -> ^pattern_t ---
		user_to_device :: proc(cr: ^context_t, x: ^f64, y: ^f64) ---
		user_to_device_distance :: proc(cr: ^context_t, dx: ^f64, dy: ^f64) ---
		version :: proc() -> i32 ---
		version_string :: proc() -> cstring ---

	types
		antialias_t :: enum u32 {DEFAULT = 0, NONE = 1, GRAY = 2, SUBPIXEL = 3, FAST = 4, GOOD = 5, BEST = 6}
		bool_t :: b32
		color_mode_t :: enum u32 {DEFAULT = 0, NO_COLOR = 1, COLOR = 2}
		content_t :: enum u32 {COLOR = 4096, ALPHA = 8192, COLOR_ALPHA = 12288}
		context_t :: struct #packed {}
		destroy_func_t :: #type proc(data: rawptr)
		device_t :: struct #packed {}
		device_type_t :: enum i32 {DRM = 0, GL = 1, SCRIPT = 2, XCB = 3, XLIB = 4, XML = 5, COGL = 6, WIN32 = 7, INVALID = -1}
		dither_t :: enum u32 {NONE = 0, DEFAULT = 1, FAST = 2, GOOD = 3, BEST = 4}
		extend_t :: enum u32 {NONE = 0, REPEAT = 1, REFLECT = 2, PAD = 3}
		fill_rule_t :: enum u32 {WINDING = 0, EVEN_ODD = 1}
		filter_t :: enum u32 {FAST = 0, GOOD = 1, BEST = 2, NEAREST = 3, BILINEAR = 4, GAUSSIAN = 5}
		font_extents_t :: struct {ascent: f64, descent: f64, height: f64, max_x_advance: f64, max_y_advance: f64}
		font_face_t :: struct #packed {}
		font_options_t :: struct #packed {}
		font_slant_t :: enum u32 {NORMAL = 0, ITALIC = 1, OBLIQUE = 2}
		font_type_t :: enum u32 {TOY = 0, FT = 1, WIN32 = 2, QUARTZ = 3, USER = 4, DWRITE = 5}
		font_weight_t :: enum u32 {NORMAL = 0, BOLD = 1}
		format_t :: enum i32 {INVALID = -1, ARGB32 = 0, RGB24 = 1, A8 = 2, A1 = 3, RGB16_565 = 4, RGB30 = 5, RGB96F = 6, RGBA128F = 7}
		glyph_t :: struct {index: u64, x: f64, y: f64}
		header_struct_anon_0 :: struct {type: path_data_type_t, length: i32}
		hint_metrics_t :: enum u32 {DEFAULT = 0, OFF = 1, ON = 2}
		hint_style_t :: enum u32 {DEFAULT = 0, NONE = 1, SLIGHT = 2, MEDIUM = 3, FULL = 4}
		line_cap_t :: enum u32 {BUTT = 0, ROUND = 1, SQUARE = 2}
		line_join_t :: enum u32 {MITER = 0, ROUND = 1, BEVEL = 2}
		matrix_t :: struct {xx: f64, yx: f64, xy: f64, yy: f64, x0: f64, y0: f64}
		operator_t :: enum u32 {CLEAR = 0, SOURCE = 1, OVER = 2, IN = 3, OUT = 4, ATOP = 5, DEST = 6, DEST_OVER = 7, DEST_IN = 8, DEST_OUT = 9, DEST_ATOP = 10, XOR = 11, ADD = 12, SATURATE = 13, MULTIPLY = 14, SCREEN = 15, OVERLAY = 16, DARKEN = 17, LIGHTEN = 18, COLOR_DODGE = 19, COLOR_BURN = 20, HARD_LIGHT = 21, SOFT_LIGHT = 22, DIFFERENCE = 23, EXCLUSION = 24, HSL_HUE = 25, HSL_SATURATION = 26, HSL_COLOR = 27, HSL_LUMINOSITY = 28}
		path :: struct {status: status_t, data: ^path_data_t, num_data: i32}
		path_data_t :: struct #raw_union {header: header_struct_anon_0, point: point_struct_anon_1}
		path_data_type_t :: enum u32 {MOVE_TO = 0, LINE_TO = 1, CURVE_TO = 2, CLOSE_PATH = 3}
		path_t :: path
		pattern_t :: struct #packed {}
		pattern_type_t :: enum u32 {SOLID = 0, SURFACE = 1, LINEAR = 2, RADIAL = 3, MESH = 4, RASTER_SOURCE = 5}
		point_struct_anon_1 :: struct {x: f64, y: f64}
		raster_source_acquire_func_t :: #type proc(pattern: ^pattern_t, callback_data: rawptr, target: ^surface_t, extents: ^rectangle_int_t) -> ^surface_t
		raster_source_copy_func_t :: #type proc(pattern: ^pattern_t, callback_data: rawptr, other: ^pattern_t) -> status_t
		raster_source_finish_func_t :: #type proc(pattern: ^pattern_t, callback_data: rawptr)
		raster_source_release_func_t :: #type proc(pattern: ^pattern_t, callback_data: rawptr, surface: ^surface_t)
		raster_source_snapshot_func_t :: #type proc(pattern: ^pattern_t, callback_data: rawptr) -> status_t
		read_func_t :: #type proc(closure: rawptr, data: [^]u8, length: u32) -> status_t
		rectangle_int_t :: struct {x: i32, y: i32, width: i32, height: i32}
		rectangle_list_t :: struct {status: status_t, rectangles: [^]rectangle_t, num_rectangles: i32}
		rectangle_t :: struct {x: f64, y: f64, width: f64, height: f64}
		region_overlap_t :: enum u32 {IN = 0, OUT = 1, PART = 2}
		region_t :: struct #packed {}
		scaled_font_t :: struct #packed {}
		status_t :: enum u32 {SUCCESS = 0, NO_MEMORY = 1, INVALID_RESTORE = 2, INVALID_POP_GROUP = 3, NO_CURRENT_POINT = 4, INVALID_MATRIX = 5, INVALID_STATUS = 6, NULL_POINTER = 7, INVALID_STRING = 8, INVALID_PATH_DATA = 9, READ_ERROR = 10, WRITE_ERROR = 11, SURFACE_FINISHED = 12, SURFACE_TYPE_MISMATCH = 13, PATTERN_TYPE_MISMATCH = 14, INVALID_CONTENT = 15, INVALID_FORMAT = 16, INVALID_VISUAL = 17, FILE_NOT_FOUND = 18, INVALID_DASH = 19, INVALID_DSC_COMMENT = 20, INVALID_INDEX = 21, CLIP_NOT_REPRESENTABLE = 22, TEMP_FILE_ERROR = 23, INVALID_STRIDE = 24, FONT_TYPE_MISMATCH = 25, USER_FONT_IMMUTABLE = 26, USER_FONT_ERROR = 27, NEGATIVE_COUNT = 28, INVALID_CLUSTERS = 29, INVALID_SLANT = 30, INVALID_WEIGHT = 31, INVALID_SIZE = 32, USER_FONT_NOT_IMPLEMENTED = 33, DEVICE_TYPE_MISMATCH = 34, DEVICE_ERROR = 35, INVALID_MESH_CONSTRUCTION = 36, DEVICE_FINISHED = 37, JBIG2_GLOBAL_MISSING = 38, PNG_ERROR = 39, FREETYPE_ERROR = 40, WIN32_GDI_ERROR = 41, TAG_ERROR = 42, DWRITE_ERROR = 43, SVG_FONT_ERROR = 44, LAST_STATUS = 45}
		subpixel_order_t :: enum u32 {DEFAULT = 0, RGB = 1, BGR = 2, VRGB = 3, VBGR = 4}
		surface_observer_callback_t :: #type proc(observer: ^surface_t, target: ^surface_t, data: rawptr)
		surface_observer_mode_t :: enum u32 {NORMAL = 0, RECORD_OPERATIONS = 1}
		surface_t :: struct #packed {}
		surface_type_t :: enum u32 {IMAGE = 0, PDF = 1, PS = 2, XLIB = 3, XCB = 4, GLITZ = 5, QUARTZ = 6, WIN32 = 7, BEOS = 8, DIRECTFB = 9, SVG = 10, OS2 = 11, WIN32_PRINTING = 12, QUARTZ_IMAGE = 13, SCRIPT = 14, QT = 15, RECORDING = 16, VG = 17, GL = 18, DRM = 19, TEE = 20, XML = 21, SKIA = 22, SUBSURFACE = 23, COGL = 24}
		text_cluster_flags_bit_t :: enum u32 {BACKWARD = 0}
		text_cluster_flags_t :: bit_set[text_cluster_flags_bit_t]
		text_cluster_t :: struct {num_bytes: i32, num_glyphs: i32}
		text_extents_t :: struct {x_bearing: f64, y_bearing: f64, width: f64, height: f64, x_advance: f64, y_advance: f64}
		user_data_key_t :: struct {unused: i32}
		user_scaled_font_init_func_t :: #type proc(scaled_font: ^scaled_font_t, cr: ^context_t, extents: ^font_extents_t) -> status_t
		user_scaled_font_render_glyph_func_t :: #type proc(scaled_font: ^scaled_font_t, glyph: u64, cr: ^context_t, extents: ^text_extents_t) -> status_t
		user_scaled_font_text_to_glyphs_func_t :: #type proc(scaled_font: ^scaled_font_t, utf8: cstring, utf8_len: i32, glyphs: ^[^]glyph_t, num_glyphs: ^i32, clusters: ^[^]text_cluster_t, num_clusters: ^i32, cluster_flags: ^text_cluster_flags_t) -> status_t
		user_scaled_font_unicode_to_glyph_func_t :: #type proc(scaled_font: ^scaled_font_t, unicode: u64, glyph_index: ^u64) -> status_t
		write_func_t :: #type proc(closure: rawptr, data: [^]u8, length: u32) -> status_t

	files:
		cairo.odin
		patched.odin
```
