var _damage_taken = argument0;
var _direction_hit_from = argument1;

state = PLAYER_STATE.HIT;
vulnerable = false;
if (sprite_index != self.hit_spr or mask_index != self.hit_spr){
	sprite_index = self.hit_spr;
	mask_index = self.hit_spr;
}
hp -= _damage_taken;
curr_hspeed = 0;
if (_direction_hit_from > 0) {
//	x += 10;
}
else {
//	x -= 10;
}
if (hp > 0) {
	state = PLAYER_STATE.HIT;
}
else {
	state = PLAYER_STATE.DEAD;
	scr_player_state_dead();
}

if (scr_animation_end()) {
	state = PLAYER_STATE.IDLE;
	iframe_countdown = true;
}