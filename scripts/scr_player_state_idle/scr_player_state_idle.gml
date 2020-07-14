
#region //determine movement and current sprite index
var _direction_to_move = right_input - left_input; //kb checks return bools so this is always -1 (left), 0 (still), or 1 (right)

if (_direction_to_move == 1) {
	sprite_index = spr_knight_run;
	mask_index = spr_knight_run;
	image_xscale = 1;
} else if (_direction_to_move == -1) {
	sprite_index = spr_knight_run;
	mask_index = spr_knight_run;
	image_xscale = -1;
} else {
	sprite_index = spr_knight_idle;
	mask_index = spr_knight_idle;
}

curr_hspeed = _direction_to_move * walk_speed; //determines which way we're walking if at all
curr_vspeed += gravity_constant; //always accelerating downward but not moving downward if on/right above barrier

//if sprite is standing and has pressed jump
if (place_meeting(x, y+1, obj_flat_barrier) && jump_input) {
	//set vertical to negative jump speed since down is positive in graphics or whatever
	//gravity is always applied so will fall on its own
	curr_vspeed = -jump_speed;
}

if (!place_meeting(x, y+1, obj_flat_barrier) && curr_vspeed > 0) {
	sprite_index = spr_knight_fall;
} else if (curr_vspeed < 0) {
	sprite_index = spr_knight_jump;
}

#endregion

#region //handle horizontal and vertical collisions with barriers
/* instead of using a collision event, stop the sprite 
	 right before it collides with barrier by checking
	 if, assuming sprite continues moving with curr velocity,
	 sprite will collide with barrier on the next frame.
	 if it will collide, reduce speed towards barrier until
	 only 1 pixel separates sprite and barrier
*/
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
x += curr_hspeed;

if (place_meeting(x, y+curr_vspeed, obj_flat_barrier)) {
	while (!place_meeting(x, y+sign(curr_vspeed), obj_flat_barrier)) {
		y += sign(curr_vspeed);
	}
	curr_vspeed = 0;
}
y += curr_vspeed;

#endregion

//determine if should move to attack state
if (attack_input) {
	state = PLAYER_STATE.ATTACKING;
}