// Mark modules soon to be deleted
for (var _m = 0; _m < array_length(marked_modules); _m++)
{
	var _module_pos = marked_modules[_m].position; 
	draw_set_color(c_red);
	draw_set_alpha(0.3);
	draw_rectangle(_module_pos.x1*tile_size, _module_pos.y1*tile_size, 
				_module_pos.x1*tile_size + tile_size*module_size-1, _module_pos.y1*tile_size + tile_size*module_size-1, false)
	draw_set_color(c_white);
	draw_set_alpha(1);
}

// Only draw unit lines if it's the player's turn;
if turn_team == 0
{
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
}
if enemy_draw_line
{
	if enemy_line_color == 1 draw_set_color(c_red);
	else if enemy_line_color == 2 draw_set_color(c_purple);
	
	draw_arrow(enemy_move_start.x, enemy_move_start.y, enemy_move_end.x, enemy_move_end.y, 15);
}

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