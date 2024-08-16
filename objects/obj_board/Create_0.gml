// Creates a square board with x tiles.
size = 20;
tile_size = 32;

selected_unit = noone;	//Currently selected unit.
is_selection_valid = false;	// Used for checking valid move spaces

// Used for selecting units and drawing selections
mouse_grid = new Vector(0, 0);

// Board drawing and selection
possible_moves = [];



//// ---------------------
//// FUNCTIONS AND STRUCTS
//// ---------------------

//Tile Class for tile data
Tile = function(_color = "white", _unit = noone) constructor
{
	color = _color;
	unit = _unit;
	texture = 0;
	self.SetTileTexture();
	
	static SetTileTexture = function()
	{
		var _random_black = [7, 11];
		var _random_white = [1, 5];
		
		if color == "white"
		{
			texture = irandom_range(_random_white[0], _random_white[1]);
		}
		else if color == "black"
		{
			texture = irandom_range(_random_black[0], _random_black[1]);
		}
	}
}


// Create the tilemap layer for the board.
var _layer = layer_create(100);
tilemap = layer_tilemap_create(_layer, 0, 0, ts_board, size, size);

// Create the board and fill it up with tile colors
board = [];
for (var _i = 0; _i < size; _i++) {
    for (var _j = 0; _j < size; _j++) {
		if (_i + _j) % 2 == 0
		{
			board[_i][_j] = new Tile("white");
		}
		else board[_i][_j] = new Tile("black");
		
		//Set the tilemap to the correct texture
		tilemap_set(tilemap, board[_i][_j].texture, _i, _j);
	}
}

// Create a unit on the board
CreateUnit = function(_cell_x, _cell_y, _unit)
{
	board[_cell_x][_cell_y].unit = instance_create_layer(_cell_x*tile_size, _cell_y*tile_size, "Units", _unit);
}

// Selects a unit and calculates the tile that it can move to
SelectUnit = function(_cell_x, _cell_y)
{
	selected_unit = board[_cell_x][_cell_y].unit;
	selected_unit.selected = true;
	
	/// In Line
	var _size_min = 0;
	var _size_max = size-1;
	var _in_line = selected_unit.in_line;
	var _horizontal_min = clamp(_cell_x - _in_line, _size_min, _size_max);
	var _horizontal_max = clamp(_cell_x + _in_line, _size_min, _size_max);
	var _vertical_min = clamp(_cell_y - _in_line, _size_min, _size_max);
	var _vertical_max = clamp(_cell_y + _in_line, _size_min, _size_max);
	
	if _in_line > 0
	{
		for(var _h = _horizontal_min; _h <= _horizontal_max; _h++)
		{
			if _h == _cell_x continue; // Skip the unit location
			var _new_tile = new Vector4(new Vector(_h, _cell_y), tile_size);
			array_push(possible_moves, _new_tile);
		}
	
		for(var _v = _vertical_min; _v <= _vertical_max; _v++)
		{
			if _v == _cell_y continue; // Skip the unit location
			var _new_tile = new Vector4(new Vector(_cell_x, _v), tile_size);
			array_push(possible_moves, _new_tile);
		}
	}	
	
	/// Diagonal
	var _diagonal = selected_unit.diagonal;
	
	if _diagonal > 0
	{
		// Check for all 4 diagonals.
		_diagonal_x = [+1, +1, -1, -1];
		_diagonal_y = [-1, +1, +1, -1];
		for (var _d = 0; _d < 4; _d++)
		{
			var _current_h = _cell_x;
			var _current_v = _cell_y;
			for (var _d2 = 0; _d2 < _diagonal; _d2++)
			{
				_current_h += _diagonal_x[_d];
				_current_v += _diagonal_y[_d];
				
				if _current_h < _size_min or _current_h > _size_max or
				   _current_v < _size_min or _current_v > _size_max
				{
					 break;	// The diagonal is at the end of the level  
				}
				
				var _new_tile = new Vector4(new Vector(_current_h, _current_v), tile_size);
				array_push(possible_moves, _new_tile);
			}
		}
	}
	
	
	///Special
	var _special_amount = array_length(selected_unit.special);
	if _special_amount > 0
	{
		_special_array = selected_unit.special;
		for(var _s = 0; _s < _special_amount; _s++)
		{
			_new_pos = new Vector(_cell_x + _special_array[_s].x, _cell_y + _special_array[_s].y);
			
			// Check for out of bounds and non changing positions.
			if _new_pos.x < _size_min or _new_pos.x > _size_max or
			   _new_pos.y < _size_min or _new_pos.y > _size_max or
			   (_new_pos.x == _cell_x and _new_pos.y == _cell_y)
			{
				continue;
			}
			
			array_push(possible_moves, new Vector4(_new_pos, tile_size));
		}
	}
}

// Used for moving units between tiles
MoveUnit = function(_prev_cell_x, _prev_cell_y, _new_cell_x, _new_cell_y)
{	
	var _prev_tile = board[_prev_cell_x, _prev_cell_y];
	var _new_tile = board[_new_cell_x, _new_cell_y];
	
	if _new_tile.unit != noone 
	{
		CancelSelection(); // Currently only move to empty tile.
		return;
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



//// ---------------------
//// SETUP CALLS
//// ---------------------
CreateUnit(4, 4, obj_unit);
CreateUnit(2, 3, obj_unit);
board[2,3].unit.diagonal = 3;
board[2,3].unit.in_line = 0;
CreateUnit(5, 5, obj_unit);
board[5,5].unit.in_line = 0;
board[5,5].unit.special = [new Vector(-1, -2), new Vector(1, -2), new Vector(-1, 2), new Vector(1, 2),
						   new Vector(-2, -1), new Vector(-2, 1), new Vector(2, -1), new Vector(2, 1)];

sprite_index = -1;	//Hide the sprite