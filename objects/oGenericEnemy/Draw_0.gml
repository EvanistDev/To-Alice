draw_set_valign(fa_middle)
draw_set_halign(fa_middle)

#region Combat
	if (global.inCombat) {
		if (ActionTime) {
			draw_sprite_ext(sprite_index, image_index, x, y, 1.1, 1.1, 0, c_black, 1)
			draw_sprite(sIndicator, 0, x, y -  sprite_height / 1.5)	
		}

		/*DEBUG ONLY*/
		draw_text(x, y + sprite_height / 1.5, $"{status.hp}/{status.hpMax}")
		draw_text(x, y, maxAttack)
	}
#endregion

draw_sprite_ext(sprite_index, sprite_index, x, y, 1, 1, 0, status.color, 1)

/* DEBUG */
if (not global.inCombat)
	draw_circle(x, y, detectPlayer, true)

draw_set_valign(-1)
draw_set_halign(-1)

/* DEBUG */
if (not global.inCombat) {
	draw_text(30, 30, escape ? "ESCAPE" : "CHASING")
	draw_text(30, 50, "Press ENTER to change the mode")
	if keyboard_check_pressed(vk_enter) escape = !escape
}