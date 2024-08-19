selected = false;
team = 0;	// Team 0 is player

// Apply shader when dead
is_dead = false;
dissolve_amount = 1;
shader_dissolve = shader_get_uniform(sh_dissolve, "u_dissolve_amount");

// Convert pixel to tile position.
position = new Vector(x div 32, y div 32);

image_index = irandom_range(0, 5);

/// Possible movements.
/// -------------------

// Horizontal and vertical, like a rook
in_line = 3;

// Diagonal like a bishop
diagonal = 0;

// Special movement, like a horse
special = [];

/// Functions
/// ----------
// Activates destruction sequence for the unit
Destroy = function(_grid_x, _grid_y, _tile_size)
{
	is_dead = true;
	
	// Rotate the enemy direction to simulate knockback
	var _x1 = _grid_x*_tile_size+_tile_size/2;
	var _y1 = _grid_y*_tile_size+_tile_size/2;
	var _x2 = x;
	var _y2 = y;
		
	var _direction = point_direction(_x1, _y1, _x2, _y2);
	speed = 0.4;
	direction = _direction;
}

FindImage = function()
{
	var _special = array_length(special);
	if _special > 0 image_index = 2;	// horse
	else if in_line == 1 and diagonal == 1 image_index = 3; // king
	else if in_line == 0 and diagonal >= 2 image_index = 5; // bishop
	else if in_line >= 2 and diagonal == 0 image_index = 1; // rook
	else if in_line >= 1 and diagonal >= 1 image_index = 4; // queen
	else image_index = 0;	// pawn
}