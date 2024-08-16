draw_set_color(c_aqua);
draw_text(0, 0, $"{mouse_x}, {mouse_y}");

draw_text(0, 20, $"{device_mouse_x_to_gui(0)}, {device_mouse_y_to_gui(0)}");

draw_text(0, 40, $"{camera_get_view_width(camera)}, {camera_get_view_height(camera)}");