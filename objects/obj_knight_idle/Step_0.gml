/// @description get input, manage state machine
// You can write your code in this editor

#region grab input
right_input = keyboard_check(ord("D"));
left_input = keyboard_check(ord("A"));
jump_input = keyboard_check_pressed(ord("W"));
attack_input = keyboard_check_pressed(vk_space);
#endregion

#region player state switch statement
switch(state) {
	case PLAYER_STATE.IDLE:
		scr_player_state_idle();
		break;
	case PLAYER_STATE.ATTACKING:
		scr_player_state_attacking();
		break;
	case PLAYER_STATE.ATTACKING_COMBO:
		scr_player_state_attacking_combo();
		break;
}
#endregion