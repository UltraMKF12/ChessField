camera_w = 16*40;
camera_h = 9*40;
var _windows_upscale = 3;

camera_speed = 6;


// Create the camera and enable it.
camera = camera_create_view(0, 0, camera_w, camera_h);
view_enabled = true;
view_visible[0] = true;
view_camera[0] = camera;


// Resize the game to represent the camera
var _new_w = camera_w*_windows_upscale;
var _new_h = camera_h*_windows_upscale;
surface_resize(application_surface, _new_w, _new_h);	// Changes aspect ratio
display_set_gui_size(_new_w, _new_h);					// Changes GUI pixel density
window_set_size(_new_w, _new_h);						// Changes window size
window_center();


sprite_index = -1;	//Hide the sprite