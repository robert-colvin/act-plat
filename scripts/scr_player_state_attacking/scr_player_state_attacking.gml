
if (sprite_index != self.attack_spr) {
	sprite_index = self.attack_spr;
	image_index = 0;
	ds_list_clear(enemies_hit);
}

//set hitbox and check for hits
mask_index = self.attack_hitbox_spr;

var _enemies_currently_hit = ds_list_create();

for (var _i = 0; _i < array_length_1d(global.enemy_types); _i++) {
	var _curr_enemy_hits = instance_place_list(x, y, global.enemy_types[_i], _enemies_currently_hit, false);
	if (_curr_enemy_hits > 0) {
		for (var _j = 0; _j < _curr_enemy_hits; _j++) {
			var _hit_id = _enemies_currently_hit[|_j];
			
			if (_hit_id.state != ENEMY_STATE.DEAD and ds_list_find_index(enemies_hit, _hit_id) == -1) {
				ds_list_add(enemies_hit, _hit_id);
				with (_hit_id) {
					sprite_index = self.hit_spr;
					scr_enemy_state_hit(1);
				}
			}
		}
	}
}
ds_list_destroy(_enemies_currently_hit);

mask_index = self.idle_spr;

if (scr_animation_end()) {
	sprite_index = self.idle_spr;
	state = PLAYER_STATE.IDLE;
} else {
	var _direction_to_move = right_input - left_input;
	curr_hspeed = _direction_to_move * walk_speed; //determines which way we're walking if at all
	curr_vspeed += gravity_constant; //always accelerating downward but not moving downward if on/right above barrier

	//if next step will collide with barrier
	if (place_meeting(x+curr_hspeed, y, obj_flat_barrier)) {
		//while sprite is able to take at least 1 step towards barrier without colliding (sign will return -1/1 depending on direction)
		while (!place_meeting(x+sign(curr_hspeed), y, obj_flat_barrier)) {
			//move one pixel clser to collision
			x += sign(curr_hspeed);
		}
		//sprite can no longer approach barrier w/o collision so stop moving
		curr_hspeed = 0;
	}
	

	if (place_meeting(x, y+curr_vspeed, obj_flat_barrier)) {
		while (!place_meeting(x, y+sign(curr_vspeed), obj_flat_barrier)) {
			y += sign(curr_vspeed);
		}
		curr_vspeed = 0;
		curr_hspeed = 0;
	}
	x += curr_hspeed;
	y += curr_vspeed;
}
