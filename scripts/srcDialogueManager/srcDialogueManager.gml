function DialogueManager() constructor {
    self.messages = [];
    self.current_msg = 0;
    self.active = false;
    self.dialogues = {};

    self.onFinished = undefined;

    self.load_json = function(json_string) {
        self.dialogues = json_parse(json_string);
    };

    self.start = function(name, _onFinished) {
        if (!variable_struct_exists(self.dialogues, name)) {
            show_debug_message("Dialogue not found: " + string(name));
            return;
        }
        
        self.messages = self.dialogues[$ name];
        self.current_msg = 0;
        self.active = true;

        if (is_callable(_onFinished)) {
            self.onFinished = _onFinished;
        } else {
            self.onFinished = undefined;
        }
    };

    self.next = function() {
        if (self.current_msg >= array_length(self.messages)) {
            self.active = false;
            if (is_callable(self.onFinished)) self.onFinished();
            return undefined;
        }

        var msg = self.messages[self.current_msg];
        self.current_msg += 1;

        if (self.current_msg >= array_length(self.messages)) {
            self.active = false;
            if (is_callable(self.onFinished)) self.onFinished();
        }

        return msg;
    };

    self.is_done = function() {
        return !self.active;
    };
}