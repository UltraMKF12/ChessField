mouse_grid = new Vector(mouse_x div tile_size, mouse_y div tile_size);


// Check if selection is valid
var _is_valid = false;
for (var _i = 0; _i < array_length(possible_moves); _i++) 
{
    if possible_moves[_i].x == mouse_grid.x and possible_moves[_i].y == mouse_grid.y
	{
		_is_valid = true;
	}
}
is_selection_valid = _is_valid;


// Exit step even if mouse out of bounds
if mouse_grid.x < 0 or mouse_grid.x >= size or
   mouse_grid.y < 0 or mouse_grid.y >= size
   exit;

if mouse_check_button_pressed(mb_left)
{
	var _selected_tile = board[mouse_grid.x][mouse_grid.y]
	if _selected_tile.unit != noone
	{
		SelectUnit(mouse_grid.x, mouse_grid.y);
		audio_play_sound(snd_unit_pickup, 1, false);
	}
}

if mouse_check_button_released(mb_left)
{
	if is_selection_valid and selected_unit != noone
	{
		MoveUnit(selected_unit.position.x, selected_unit.position.y, mouse_grid.x, mouse_grid.y);
		audio_play_sound(snd_unit_place, 1, false);
	}
	else
	{
		CancelSelection();
		audio_play_sound(snd_unit_error, 1, false);
	}
}