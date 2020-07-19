var _damage_taken = argument0;

state = ENEMY_STATE.HIT;
if (sprite_index != self.hit_spr){
	sprite_index = self.hit_spr;
	mask_index = self.hit_spr;
}
hp -= _damage_taken;
curr_hspeed = 0;
x += sign(x - obj_knight_idle.x) * 5;
if (hp > 0) {
	state = ENEMY_STATE.HIT;
	mask_index = self.hit_spr;
}
else {
	state = ENEMY_STATE.DEAD;
	mask_index = self.dead_spr;
	scr_enemy_state_dead();
}
