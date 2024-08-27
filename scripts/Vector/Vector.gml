function Vector(_x = 0, _y = 0) constructor{
	x = _x;
	y = _y;
}

// Used to store if a hit will take down an enemy or not
function VectorTakedown(_x = 0, _y = 0, _takedown = false) constructor{
	x = _x;
	y = _y;
	takedown = _takedown;
}

/// 0 - Move AND Attack | 
/// 1 - Only Move |
/// 2 - Only Attack
function VectorSpecialMove(_x = 0, _y = 0, _mode = 0) constructor{
	x = _x;
	y = _y;
	
	mode = _mode;
}

// Used for rectangular operations where
// the values need to consist of start and end positions
// with STEP values
// Ex: Drawing a rectangle
function Vector4(_vec2, _grid_size) constructor{
	x1 = _vec2.x * _grid_size;
	x2 = _vec2.x * _grid_size + _grid_size-1;
	y1 = _vec2.y * _grid_size;
	y2 = _vec2.y * _grid_size + _grid_size-1;
}