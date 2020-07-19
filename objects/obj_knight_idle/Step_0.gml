/// @description get input, manage state machine
// You can write your code in this editor

#region grab input
right_input = keyboard_check(ord("D"));
left_input = keyboard_check(ord("A"));
jump_input = keyboard_check_pressed(ord("W"));
attack_input = keyboard_check_pressed(vk_space);
#endregion

if (iframes <= 0) {
	vulnerable = true;
} else if (iframe_countdown) {
	iframes--;
	vulnerable = false;
} else {
	iframes = 20;
	iframe_countdown = false;
}
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
	case PLAYER_STATE.HIT:
		break;
	case PLAYER_STATE.DEAD:
		vulnerable = false;
		if (scr_animation_end()) {
			image_speed = 0;
			if (image_alpha > 0) {
				image_alpha -= 0.01;
			}
			if (image_alpha <= 0) {
				instance_destroy();
			}
		}
		break;
}
#endregion