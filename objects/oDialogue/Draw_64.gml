if (!dialogue_manager.active) exit;

var dx = 0;
var dy = display_get_gui_height() * 0.7;
var box_width = display_get_gui_width();
var box_height = display_get_gui_height() - dy;

var portrait_height = box_height - 32;
var portrait_x = dx + 16;
var portrait_y = dy + 16;

var msg_struct = dialogue_manager.messages[dialogue_manager.current_msg];

if (char_ptr == 0 or current_sprite = -1) {
    str = msg_struct.msg;

    if (variable_struct_exists(msg_struct, "sprite")) {
		switch (msg_struct.sprite) {
			case "sSlime": current_sprite = sSlime; break;
			case "sAliceHead": current_sprite = sAliceHead; break;
		}
    } else {
		show_debug_message("\n\nNo Sprite Property On Dialogue Entry!\n\n");
        current_sprite = -1; 
    }
}

if (char_ptr < string_length(str)) {
    char_ptr += typing_speed * (1 + keyboard_check(input_key));
    current_text = string_copy(str, 1, floor(char_ptr));
} else {
    current_text = str;

    if (keyboard_check_pressed(input_key)) {
        var next_msg = dialogue_manager.next();
        if (dialogue_manager.active) {
            char_ptr = 0;
        } else {
            dialogue_manager.active = false;
            instance_destroy();
        }
    }
}

draw_set_colour(c_black)
draw_sprite_stretched(dialogue_box_sprite, 0, dx, dy, box_width, box_height);
draw_sprite_stretched(dialogue_box_sprite, 0, dx, dy, box_width, box_height);

var text_x_offset = 16;
if (current_sprite != -1) {
    var spr_w = sprite_get_width(current_sprite);
    var spr_h = sprite_get_height(current_sprite);

    var scale = portrait_height / spr_h;
    var draw_w = spr_w * scale;
    var draw_h = spr_h * scale;

    draw_sprite_ext(current_sprite, 0,
                    portrait_x + draw_w/2,
                    portrait_y + draw_h/2,
                    scale, scale, 0, c_white, 1);

    text_x_offset = draw_w + 16;
}

var text_x = portrait_x + text_x_offset;
var text_y = dy + 16;

draw_set_colour(#222034)
draw_set_font(FntButtons)

draw_text(text_x, text_y, msg_struct.name);
draw_text_ext(text_x, text_y + 32, current_text, -1, box_width - text_x - 16);

draw_set_colour(-1)
draw_set_font(-1)
