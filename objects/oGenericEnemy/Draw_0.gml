draw_set_valign(fa_middle)
draw_set_halign(fa_middle)

#region Combat
	if (global.inCombat) {
		
		if (ActionTime)
			draw_sprite_ext(sprite_index, image_index, x, y, 1.1, 1.1, 0, c_black, 1)

		/*DEBUG ONLY*/
		draw_text(x, y + sprite_height / 1.5, $"{status.hp}/{status.hpMax}")
		draw_text(x, y, maxAttack)
	}


	if (hitFlash) {
		gpu_set_fog(true, c_white, 0, 1);
		draw_sprite_ext(sprite_index, sprite_index, x, y, 1, 1, 0, status.color, 1)
		gpu_set_fog(false, c_white, 0, 1);
	} else
		draw_sprite_ext(sprite_index, sprite_index, x, y, 1, 1, 0, status.color, 1)
	
	if (showDamage) {
		draw_set_font(FntButtons) 
		
		var _textX = x + sprite_width/2 + 25
		
		// Shadow
		draw_set_alpha(damageAlpha * 0.5)
		draw_set_color(c_black)
		draw_text(_textX + 2, damageY + 2, $"-{damageValue}")
		
		// Text
		draw_set_alpha(damageAlpha)
		draw_set_color(c_red)
		draw_text(_textX, damageY, $"-{damageValue}")
	}
#endregion


draw_set_valign(fa_top)
draw_set_halign(fa_left)
draw_set_color(c_white)
draw_set_alpha(1)
draw_set_font(1)

/* DEBUG */
if (not global.inCombat) {
	draw_text(30, 30, escape ? "ESCAPE" : "CHASING")
	draw_text(30, 50, "Press ENTER to change the mode")
	if keyboard_check_pressed(vk_enter) escape = !escape
}