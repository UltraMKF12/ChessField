function Vector(_x = 0, _y = 0) constructor{
	x = _x;
	y = _y;
}

// Used for rectangular drawing
function Vector4(_vec2, _grid_size) constructor{
	x1 = _vec2.x * _grid_size;
	x2 = _vec2.x * _grid_size + _grid_size-1;
	y1 = _vec2.y * _grid_size;
	y2 = _vec2.y * _grid_size + _grid_size-1;
}