// Draw small yellow halo behind unmoved players
if team == 0 and can_move and not selected
{
	draw_sprite(spr_gradient, 0, x, y);
}


if is_dead
{
	dissolve_amount -= 2/60;
	
	shader_set(sh_dissolve);
	shader_set_uniform_f(shader_dissolve, dissolve_amount);
	draw_self();
	shader_reset();
	
	if dissolve_amount <= 0 instance_destroy();
}
else
{
	draw_self();
}