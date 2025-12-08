if (!dialogue_manager.active) exit;

if (char_ptr == 0) {
    var msg_struct = dialogue_manager.messages[dialogue_manager.current_msg];
    str = msg_struct.msg;
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