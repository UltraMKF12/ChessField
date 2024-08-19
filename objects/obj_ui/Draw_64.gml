// Camera related
draw_set_color(c_aqua);
draw_set_valign(fa_top);
draw_set_halign(fa_left);
draw_text(0, 0, $"{mouse_x}, {mouse_y}");
draw_text(0, 20, $"{device_mouse_x_to_gui(0)}, {device_mouse_y_to_gui(0)}");
draw_text(0, 40, $"{camera_get_view_width(obj_camera.camera)}, {camera_get_view_height(obj_camera.camera)}");

// Unit related
var _team0 = 0;
var _team1 = 0;
with (obj_unit)
{
	if team == 0 _team0++;
	else if team == 1 _team1++;
}
var _middle = display_get_gui_width() / 2;

draw_set_color(c_white);
draw_set_valign(fa_top);
draw_set_halign(fa_center);
draw_text_transformed(_middle, 0, $"Player units: {_team0}", 2, 2, 0);

draw_set_color(c_red);
draw_text_transformed(_middle, 30, $"Enemy units: {_team1}", 2, 2, 0);




// Reset
draw_set_color(c_white);
draw_set_valign(fa_top);
draw_set_halign(fa_left);
