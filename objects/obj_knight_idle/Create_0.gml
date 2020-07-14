/// @description object setup and vars
#region movement vars
curr_hp = 5;
curr_hspeed = 0;
curr_vspeed = 0;
gravity_constant = 0.5;
walk_speed = 3;
jump_speed = 8
#endregion

#region sprite vars
attack_spr = spr_knight_attack;
attack_hitbox_spr = spr_knight_attack_hitbox;
run_spr = spr_knight_run;
idle_spr = spr_knight_idle;
fall_spr = spr_knight_fall;
jump_spr = spr_knight_jump;
hit_spr = spr_knight_hit;
dead_spr = spr_knight_dead;
#endregion

#region camera vars
view_midpoint_x = camera_get_view_width(view_camera[0]) / 2;
view_midpoint_y = camera_get_view_height(view_camera[0]) / 2;
#endregion

//keep track of all enemies hit by the current attack animation
enemies_hit = ds_list_create();

#region player state enum
state = PLAYER_STATE.IDLE;

enum PLAYER_STATE {
	IDLE,
	ATTACKING,
	ATTACKING_COMBO
}
#endregion

//maintain list of objects that represent all enemy types
//to be iterated over when calculating hit detection
global.enemy_types[0] = obj_wizard;