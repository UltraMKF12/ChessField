// Creates a square board with x tiles.
module_amount = 5;
module_size = 4;

// General Board properties
size = module_amount * module_size;
tile_size = 32;

board = [];		// Stores every tile
modules = [];	// Stores every module

selected_unit = noone;		//Currently selected unit.
is_selection_valid = false;	// Used for checking if movement would be valid

// Used for converting mouse position to board tile position.
mouse_grid = new Vector(0, 0);

// Containes all the tiles where the currently selected unit can move
possible_moves = [];


// Ranges for tileset (Drawing the board)
var _random_black = [7, 11];
var _random_white = [1, 5];


//// --------
//// STRUCTS
//// --------

// Struct representing a single Tile on the board
Tile = function(_range) constructor
{
	is_enabled = false;
	texture = irandom_range(_range[0], _range[1]);
	unit = noone;
}

// Struct representing a single Module on the board.
Module = function(_position) constructor
{
	// Tile positions on the board
	position = _position;
	is_enabled = false;
}


//// -------------------------------
//// Creating the Board and Modules
//// -------------------------------

// Create the tilemap layer for the board.
var _layer = layer_create(100);
tilemap = layer_tilemap_create(_layer, 0, 0, ts_board, size, size);

// Fill the board up with tiles of alternating black and white.
for (var _t1 = 0; _t1 < size; _t1++) {
    for (var _t2 = 0; _t2 < size; _t2++) {
		if (_t1 + _t2) % 2 == 0
		{
			board[_t1][_t2] = new Tile(_random_white);
		}
		else board[_t1][_t2] = new Tile(_random_black);
	}
}

// Create the modules
for (var _m1 = 0; _m1 < module_amount; _m1++) {
	for (var _m2 = 0; _m2 < module_amount; _m2++) {
		var _position = new Vector4(new Vector(_m1, _m2), module_size);
		modules[_m1][_m2] = new Module(_position);
	}
}


//// ---------------------------------
//// Functions for Board modifications
//// ---------------------------------

// Redraw the tileset
RedrawBoard = function()
{
	for (var _t1 = 0; _t1 < size; _t1++) {
	    for (var _t2 = 0; _t2 < size; _t2++) {
			if board[_t1][_t2].is_enabled
			{
				tilemap_set(tilemap, board[_t1][_t2].texture, _t1, _t2);
			}
			else
			{
				tilemap_set(tilemap, 0, _t1, _t2);
			}
		}
	}
}

// Create a unit on the board
CreateUnit = function(_cell_x, _cell_y, _unit, _team = 0)
{
	var _new_unit = instance_create_layer(_cell_x*tile_size, _cell_y*tile_size, "Units", _unit);
	board[_cell_x][_cell_y].unit = _new_unit;
	_new_unit.team = _team;
}

// Selects a unit and calculates the tile that it can move to
SelectUnit = function(_cell_x, _cell_y)
{
	selected_unit = board[_cell_x][_cell_y].unit;
	if selected_unit == noone return;
	selected_unit.selected = true;
	
	var _size_min = 0;
	var _size_max = size-1;
	var _in_line = selected_unit.in_line;
	var _diagonal = selected_unit.diagonal;
	var _team = selected_unit.team;
	
	// Horizontal and vertical line check
	// These moves get blocked when it intersects an enemy or an ally
	var _directions_x = [];
	var _directions_y = [];
	var _directions_movement = []; // How many tiles can it move in that direction;
	if _in_line > 0
	{
		_directions_x = [0, 1, 0, -1];
		_directions_y = [-1, 0, 1, 0];
		_directions_movement = [_in_line, _in_line, _in_line, _in_line];
	}
	if _diagonal > 0
	{
		_directions_x = array_concat(_directions_x, [+1, +1, -1, -1]);
		_directions_y = array_concat(_directions_y, [-1, +1, +1, -1]);
		_directions_movement = array_concat(_directions_movement, [_diagonal, _diagonal, _diagonal, _diagonal]);
	}
	
	for(var _dir = 0; _dir < array_length(_directions_x); _dir++)
	{
		var _current_x = _cell_x;
		var _current_y = _cell_y;
		for (var _dir2 = 0; _dir2 < _directions_movement[_dir]; _dir2++) {
		    _current_x += _directions_x[_dir];
			_current_y += _directions_y[_dir];
			
			// Check for table out of bounds
			if _current_x < _size_min or _current_x > _size_max or
			   _current_y < _size_min or _current_y > _size_max
			{
				break;
			}
			
			// Check if its an not existing tile (It felt down)
			if board[_current_x][_current_y].texture == 0 break;
			
			// Check if it's a unit in the same team
			var _unit = board[_current_x][_current_y].unit;
			if _unit != noone and _unit.team == _team break;
			
			// Add the tile to the moveset
			var _new_tile = new Vector(_current_x, _current_y);
			array_push(possible_moves, _new_tile);
			
			// If it's a different team unit, the unit cant move over it.
			if _unit != noone and _unit.team != _team break;
		}
	}
	
	
	/// Special Movements that jump over other units
	var _special_amount = array_length(selected_unit.special);
	if _special_amount > 0
	{
		_special_array = selected_unit.special;
		for(var _s = 0; _s < _special_amount; _s++)
		{
			_new_pos = new Vector(_cell_x + _special_array[_s].x, _cell_y + _special_array[_s].y);
			
			// Check for table out of bounds
			if _new_pos.x < _size_min or _new_pos.x > _size_max or
			   _new_pos.y < _size_min or _new_pos.y > _size_max
			{
				continue;
			}
			
			// Check if its an not existing tile (It felt down)
			if board[_new_pos.x][_new_pos.y].texture == 0 continue;
			
			// Check if it's a unit in the same team
			var _unit = board[_new_pos.x][_new_pos.y].unit;
			if _unit != noone and _unit.team == _team continue;
			
			// Add the tile to the moveset
			var _new_tile = new Vector(_new_pos.x, _new_pos.y);
			array_push(possible_moves, _new_tile);
			
			// If it's a different team unit, the unit cant move over it.
			if _unit != noone and _unit.team != _team continue;
		}
	}
}

// Used for moving units between tiles
MoveUnit = function(_prev_cell_x, _prev_cell_y, _new_cell_x, _new_cell_y)
{	
	var _prev_tile = board[_prev_cell_x, _prev_cell_y];
	var _new_tile = board[_new_cell_x, _new_cell_y];
	
	// Guaranteed to be an enemy unit, it's checked in the step event
	// Destroy the enemy unit
	if _new_tile.unit != noone
	{
		_new_tile.unit.Destroy(_prev_cell_x, _prev_cell_y, tile_size);
	}
	
	_new_tile.unit = _prev_tile.unit;
	_prev_tile.unit = noone;
	
	var _unit = _new_tile.unit;
	_unit.position.x = _new_cell_x;
	_unit.position.y = _new_cell_y;
	
	CancelSelection();
}

CancelSelection = function()
{
	if selected_unit == noone return;
	
	selected_unit.selected = false;
	selected_unit = noone;
	possible_moves = [];	// Reset the drawing
}

//// ----------------------------------
//// Functions for Module modifications
//// ----------------------------------

EnableModule = function(_x, _y)
{
	var _module = modules[_x][_y];
	_module.is_enabled = true;
	show_debug_message(_module.position.x1);
	for (var _t1 = _module.position.x1; _t1 <= _module.position.x2; _t1++) {
		for (var _t2 = _module.position.y1; _t2 <= _module.position.y2; _t2++) {
			board[_t1][_t2].is_enabled = true;
		}
	}
	RedrawBoard();
}

DisableModule = function(_x, _y)
{
	var _module = modules[_x][_y];
	_module.is_enabled = false;
	for (var _t1 = _module.position.x1; _t1 <= _module.position.x2; _t1++) {
		for (var _t2 = _module.position.y1; _t2 <= _module.position.y2; _t2++) {
			board[_t1][_t2].is_enabled = false;
		}
	}
	RedrawBoard();
}

//// ------------
//// SETUP CALLS
//// ------------

EnableModule(2, 2);
EnableModule(3, 2);

sprite_index = -1;	//Hide the sprite