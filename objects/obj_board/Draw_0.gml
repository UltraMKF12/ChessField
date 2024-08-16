draw_set_alpha(0.4);
draw_set_color(c_yellow);
for (var _i = 0; _i < array_length(possible_moves); _i++) {
	var _tl = possible_moves[_i];
    draw_rectangle(_tl.x1, _tl.y1, _tl.x2, _tl.y2, false);
}

draw_set_color(c_red);
if is_selection_valid
{
	var _mouse_rectangle = new Vector4(mouse_grid, 32);
	draw_rectangle(_mouse_rectangle.x1, _mouse_rectangle.y1, _mouse_rectangle.x2, _mouse_rectangle.y2, false);
}

draw_set_alpha(1);