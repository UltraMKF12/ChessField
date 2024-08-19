if selected
{
	image_blend = c_aqua;
	image_angle = 10;
	x = mouse_x-16;
	y = mouse_y-16;
	depth = -1;
}
else
{
	image_blend = c_white;
	image_angle = 0;
	x = position.x*32;
	y = position.y*32;
	depth = 0;
}

if team == 1 image_blend = c_red;
if team == 2 image_blend = c_purple;