// Get camera movement buttons
var _left_button = keyboard_check(ord("A")) or keyboard_check(vk_left);
var _right_button = keyboard_check(ord("D")) or keyboard_check(vk_right);
var _up_button = keyboard_check(ord("W")) or keyboard_check(vk_up);
var _down_button = keyboard_check(ord("S")) or keyboard_check(vk_down);
var _zoom_plus = mouse_wheel_up();
var _zoom_minus = mouse_wheel_down();

// Get current camera position
var _camera_x = camera_get_view_x(camera);
var _camera_y = camera_get_view_y(camera);


// Move camera in the desired direction
var _horizontal_movement = _right_button - _left_button;
var _vertical_movement = _down_button - _up_button;

var _new_x = _camera_x + _horizontal_movement*camera_speed;
var _new_y = _camera_y + _vertical_movement*camera_speed;
camera_set_view_pos(camera, _new_x, _new_y);


// Zoom camera (+ center camera)
var _camera_w = camera_get_view_width(camera);
var _camera_h = camera_get_view_height(camera);

if _zoom_plus and _camera_w > 160
{
	camera_set_view_size(camera, _camera_w - 160, _camera_h - 90);
	camera_set_view_pos(camera, _new_x+80, _new_y+45);
}

if _zoom_minus
{
	camera_set_view_size(camera, _camera_w + 160, _camera_h + 90);
	camera_set_view_pos(camera, _new_x-80, _new_y-45);
}



/// MISC
if keyboard_check_pressed(ord("F"))
{
	window_set_fullscreen(!window_get_fullscreen());
}

if keyboard_check_pressed(vk_escape)
{
	game_end();
}

if keyboard_check_pressed(ord("R"))
{
	game_restart();
}