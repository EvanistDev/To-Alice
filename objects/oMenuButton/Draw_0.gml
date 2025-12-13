draw_self()

draw_set_valign(fa_middle)
draw_set_halign(fa_middle)
draw_set_colour(c_black)
draw_set_font(FntButtons)

if(buttonFunction != MenuButtons.ChangeLanguage)
	draw_text(x, y, text)
else
	draw_sprite_ext(sActionButtonEarth, 0, x + 3, y + 3, 1.3, 1.3, 0, image_blend, 1)

draw_set_valign(-1)
draw_set_halign(-1)
draw_set_colour(-1)
draw_set_font(-1)
