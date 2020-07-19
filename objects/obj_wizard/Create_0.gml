/// @description Insert description here
// You can write your code in this editor
curr_hspeed = 0;
curr_vspeed = 0;
gravity_constant = 0.5;
walk_speed = 1.5;
jump_speed = 8

hp = 10;
attack_range = 125;

#region enemy state enum
state = ENEMY_STATE.IDLE;

enum ENEMY_STATE {
	IDLE,
	ATTACKING,
	ATTACKING_COMBO,
	HIT,
	DEAD
}
#endregion

#region
hit_spr = spr_wizard_hit;
dead_spr = spr_wizard_dead;
idle_spr = spr_wizard_idle;
run_spr = spr_wizard_run;
attack_spr = spr_wizard_attack;
attack_hitbox_spr = spr_wizard_attack_hitbox;
#endregion