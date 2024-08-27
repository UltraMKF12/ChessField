if not is_dead
{
	if selected and team == 0
	{
		image_blend = c_aqua;
		x = mouse_x;
		y = mouse_y;
		depth = -1;
	}
	else
	{
		image_blend = c_white;
		image_angle = 0;
		x = position.x*32 + 16;
		y = position.y*32 + 16;
		depth = 0;
		
		// Unmoved player unit sways left and right.
		if team == 0 and can_move
		{
			var _sway = sin(current_time / 250);
			image_angle = 0 + _sway*10;
		}
		
		else if team == 0 and not can_move
		{
			image_blend = c_gray;
		}
	}
}

if team == 1 image_blend = c_red;
if team == 2 image_blend = c_purple;