/// @description Insert enemy generic behavior every step

#region hit logic 
if (state == ENEMY_STATE.HIT) {
	if (sprite_index != self.hit_spr) {
		sprite_index = self.hit_spr;
		mask_index = self.hit_spr;
	}
	if (scr_animation_end()) {
		sprite_index = self.idle_spr;
		mask_index = self.idle_spr;
		state = ENEMY_STATE.IDLE;
	}

}
#endregion
#region attacking logic
else if (state == ENEMY_STATE.ATTACKING) {
	if (sprite_index != self.attack_spr or mask_index != self.attack_hitbox_spr) {
		sprite_index = self.attack_spr;
		mask_index = self.attack_spr;
	}
	if (abs(obj_knight_idle.x - x) > self.attack_range) {
		sprite_index = self.idle_spr;
		mask_index = self.idle_spr;
		state = ENEMY_STATE.IDLE;
	}
	else {
		curr_hspeed = sign(obj_knight_idle.x - x) * walk_speed/4;
		if (abs(obj_knight_idle.x - x) <= (self.attack_range/2)) {
			curr_hspeed = 0;
		}	
		x += curr_hspeed;
		
		mask_index = self.attack_hitbox_spr;
		var _player_character_hit_id = instance_place(x, y, obj_knight_idle);
		if (_player_character_hit_id != noone) {
			var _direction_hitting_from = sign(obj_knight_idle.x - x);
			with(_player_character_hit_id) {
				if (sprite_index != self.hit_spr) {
					sprite_index = self.hit_spr;
				}
				scr_player_state_hit(1, _direction_hitting_from);
			}
		}
	}
	mask_index = self.attack_spr;
}
#endregion
#region regular idle behavior
else if (state == ENEMY_STATE.IDLE) {

	curr_vspeed += gravity_constant;
	
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
		
		//calculate which direction to face and where to move to based on player position and attack when within range
		image_xscale = sign(obj_knight_idle.x - x);
		if (abs(obj_knight_idle.x - x) <= self.attack_range) {
			state = ENEMY_STATE.ATTACKING;
		}
		else {
			curr_hspeed = sign(obj_knight_idle.x - x) * walk_speed;
			// if on the ground and moving, change sprite to running sprite
			// doesn't track vertically, don't want that for now
			if (curr_hspeed != 0) {
				sprite_index = self.run_spr;
			}
		}
	}
	y += curr_vspeed;
}
#endregion
#region dead logic
// if dead, die and destroy instance
else if (state == ENEMY_STATE.DEAD or image_speed == 0) {
	if (scr_animation_end()) {
		image_speed = 0;
	}
	if (image_alpha > 0) {
		image_alpha -= 0.01;
	}
	if (image_alpha <= 0) {
		instance_destroy();
	}
}
#endregion