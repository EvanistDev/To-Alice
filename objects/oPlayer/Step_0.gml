if (global.dialogue_manager.active) exit;

// Test Code Remove Me
if (keyboard_check_pressed(vk_space)) {
	create_dialogue("intro", function() {
    show_debug_message("Dialogue finished!");
});
}

#region Movimentação
	var _eixoX = keyboard_check(ord("D")) - keyboard_check(ord("A"))
	var _eixoY = keyboard_check(ord("S")) - keyboard_check(ord("W"))
	
	var len = _eixoX == 0 and _eixoY == 0 ? 0 : spd
	var dir = point_direction(0, 0, _eixoX, _eixoY)

	var moveDirX = lengthdir_x(len, dir)
	var moveDirY = lengthdir_y(len, dir)
	
	if (not global.inCombat) {
		x += moveDirX
		y += moveDirY
	}
#endregion