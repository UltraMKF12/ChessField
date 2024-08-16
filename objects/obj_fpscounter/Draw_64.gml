draw_set_color(c_yellow);
draw_set_halign(fa_right);
draw_text_transformed(display_get_gui_width()-4, 0, current_fps, 2, 2, 0);

//Reset draw properties
draw_set_halign(fa_left);
draw_set_color(c_white);