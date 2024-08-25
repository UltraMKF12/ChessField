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


// Fix mouse position if out of bounds
if mouse_grid.x < 0 or mouse_grid.x >= size or
   mouse_grid.y < 0 or mouse_grid.y >= size
{
	mouse_grid.x = 0;
	mouse_grid.y = 0;
}


//DEUBG: Module enabling
if mouse_check_button_pressed(mb_right)
{
	var _x = mouse_grid.x div 4;
	var _y = mouse_grid.y div 4;

	if modules[_x][_y].is_enabled DisableModule(_x, _y);
	else EnableModule(_x, _y);
}

// Select unit
if mouse_check_button_pressed(mb_left)
{
	var _selected_tile = board[mouse_grid.x][mouse_grid.y]
	if _selected_tile.unit != noone
	{
		SelectUnit(mouse_grid.x, mouse_grid.y);
		audio_play_sound(snd_unit_pickup, 1, false);
	}
}

// Move unit to selected position
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

// Place unit on location.
var _zero = keyboard_check(vk_control);	// Delete unit
var _one = keyboard_check_pressed(ord("1"));
var _two = keyboard_check_pressed(ord("2"));
var _three = keyboard_check_pressed(ord("3"));
var _four = keyboard_check_pressed(ord("4"));
var _five = keyboard_check_pressed(ord("5"));
var _six = keyboard_check_pressed(ord("6"));

if _one or _two or _three or _four or _five or _six or _zero
{
	DestroyUnit(mouse_grid.x, mouse_grid.y, 0, 0);
	if		_one CreateUnit(mouse_grid.x, mouse_grid.y, obj_unit_pawn, team);
	else if _two CreateUnit(mouse_grid.x, mouse_grid.y, obj_unit_rook, team);
	else if _three CreateUnit(mouse_grid.x, mouse_grid.y, obj_unit_horse, team);
	else if _four CreateUnit(mouse_grid.x, mouse_grid.y, obj_unit_bishop, team);
	else if _five CreateUnit(mouse_grid.x, mouse_grid.y, obj_unit_queen, team);
	else if _six CreateUnit(mouse_grid.x, mouse_grid.y, obj_unit_king, team);
}

// Change team
if keyboard_check_pressed(vk_alt) team++;
if team > 2 team = 0;