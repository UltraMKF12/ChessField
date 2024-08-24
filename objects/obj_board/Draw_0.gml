draw_set_alpha(0.4);
draw_set_color(c_yellow);
for (var _i = 0; _i < array_length(possible_moves); _i++) {
	var _tl = possible_moves[_i];
	_tl = new Vector4(_tl, tile_size);
    draw_rectangle(_tl.x1, _tl.y1, _tl.x2, _tl.y2, false);
}

draw_set_color(c_red);
if is_selection_valid
{
	var _mouse_rectangle = new Vector4(mouse_grid, tile_size);
	draw_rectangle(_mouse_rectangle.x1, _mouse_rectangle.y1, _mouse_rectangle.x2, _mouse_rectangle.y2, false);
}

draw_set_alpha(1);

//draw_text(mouse_x+20, mouse_y, tilemap_get_at_pixel(tilemap, mouse_x, mouse_y));

// Draw game border.
draw_rectangle_color(0, 0, size*tile_size, size*tile_size, c_aqua, c_aqua, c_aqua, c_aqua, true);

// Draw module border.
draw_set_color(c_purple);
for (var _m1 = 0; _m1 < module_amount; _m1++)
{
	for (var _m2 = 0; _m2 < module_amount; _m2++)
	{
		var _module = modules[_m1][_m2];
		if _module.is_enabled
		{
			var _x1 = _module.position.x1*tile_size-1;
			var _y1 = _module.position.y1*tile_size-1;
			var _x2 = _module.position.x2*tile_size+tile_size-1;
			var _y2 = _module.position.y2*tile_size+tile_size-1;
			
			if _m2 > 0 and not modules[_m1][_m2-1].is_enabled
			{
				draw_line_width(_x1, _y1, _x2, _y1, 3); // Top
			}
			
			if _m2 < module_amount-1 and not modules[_m1][_m2+1].is_enabled
			{
				draw_line_width(_x1, _y2, _x2, _y2, 3); // Bottom
			}
			
			if _m1 > 0 and not modules[_m1-1][_m2].is_enabled
			{
				draw_line_width(_x1, _y1, _x1, _y2, 3); // Left
			}
			
			if _m1 < module_amount-1 and not modules[_m1+1][_m2].is_enabled
			{
				draw_line_width(_x2, _y1, _x2, _y2, 3); // Right
			}
		}
	}
}
draw_set_color(c_white);