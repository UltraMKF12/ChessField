/// @description Move Enemy
if array_length(turn_units) == 0
{
	EndTurn();	// If no more units the start next turn.
	exit;
}
var _enemy = array_pop(turn_units);

// If enemy was deleted after unit selection, make sure it doesnt crash the game.
if not instance_exists(_enemy)
{
	alarm[0] = 60;	// Skip to the next unit.
	exit;
}

// Get all the moves the enemy can make.
SelectUnit(_enemy.position.x, _enemy.position.y);

var _move_count = array_length(possible_moves);
if _move_count == 0 
{
	alarm[0] = 60;	// Skip unmovable units.
	exit;
}

// Take down an enemy unit, or move to a random direction.
var _takedown_moves = [];
for (var _m = 0; _m < _move_count; _m++)
{
	var _move = possible_moves[_m];
	if _move.takedown array_push(_takedown_moves, _move);
}

var _selected_move;
var _array;

if array_length(_takedown_moves) > 0 _array = array_shuffle(_takedown_moves)
else _array = array_shuffle(possible_moves);

_selected_move = _array[0];

enemy_move_start.x = _enemy.position.x*tile_size+16;
enemy_move_start.y = _enemy.position.y*tile_size+16;

enemy_move_end.x = _selected_move.x*tile_size+16;
enemy_move_end.y = _selected_move.y*tile_size+16;
enemy_draw_line = true;
enemy_line_color = turn_team;	// This fixes bug that last red unit line is drawn purple

MoveUnit(_enemy.position.x, _enemy.position.y, _selected_move.x, _selected_move.y);

if array_length(turn_units) == 0
{
	EndTurn();	// If no more units the start next turn.
	exit;
}

// Go to the nex unit
alarm[0] = 60;