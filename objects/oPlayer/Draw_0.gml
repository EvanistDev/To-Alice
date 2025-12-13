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
	}
#endregion

draw_self()

draw_set_valign(-1)
draw_set_halign(-1)