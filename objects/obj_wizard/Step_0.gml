/// @description Insert description here
// You can write your code in this editor
if (image_speed == 0 or state == 4) {
	if (scr_animation_end()) {
		image_speed = 0;
	}
	if (image_alpha > 0) {
		image_alpha -= 0.01;
	}
	if (image_alpha <= 0) {
		instance_destroy();
	}
} else {

	if (state == ENEMY_STATE.HIT and scr_animation_end()) {
		sprite_index = self.idle_spr;
		state = ENEMY_STATE.IDLE;
	}

	curr_vspeed += gravity_constant;
	var _player_relative_position = point_direction(x,y, obj_knight_idle.x, obj_knight_idle.y);
	
	//move_towards_point(obj_knight_idle.x, y, walk_speed);
	
	if (place_meeting(x+curr_hspeed, y, obj_flat_barrier)) {
		//while sprite is able to take at least 1 step towards barrier without colliding (sign will return -1/1 depending on direction)
		while (!place_meeting(x+sign(curr_hspeed), y, obj_flat_barrier)) {
			//move one pixel clser to collision
			x += sign(curr_hspeed);
		}
		//sprite can no longer approach barrier w/o collision so stop moving
		curr_hspeed = 0;
	}
	x += curr_hspeed;

	if (place_meeting(x, y+curr_vspeed, obj_flat_barrier)) {
		while (!place_meeting(x, y+sign(curr_vspeed), obj_flat_barrier)) {
			y += sign(curr_vspeed);
		}
		curr_vspeed = 0;
		
		image_xscale = sign(obj_knight_idle.x - x);
		curr_hspeed = sign(obj_knight_idle.x - x) * walk_speed;
		if (curr_hspeed != 0) {
			sprite_index = run_spr;
		}
	}
	y += curr_vspeed;
}