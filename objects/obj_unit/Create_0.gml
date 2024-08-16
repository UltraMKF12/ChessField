selected = false;

// Convert pixel to tile position.
position = new Vector(x div 32, y div 32);



/// Possible movements.
/// -------------------

// Horizontal and vertical, like a rook
in_line = 3;

// Diagonal like a bishop
diagonal = 0;

// Special movement, like a horse
special = [];