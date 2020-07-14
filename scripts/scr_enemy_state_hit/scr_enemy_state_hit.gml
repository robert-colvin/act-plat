var _damage_taken = argument0;

hp -= _damage_taken;
curr_hspeed = 0;
x += sign(x - obj_knight_idle.x) * 5;
if (hp > 0) {
	state = ENEMY_STATE.HIT;
}
else {
	state = ENEMY_STATE.DEAD;
	scr_enemy_state_dead();
}
