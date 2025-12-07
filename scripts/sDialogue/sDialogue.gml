function create_dialogue(name, onFinished) {
	var _inst = undefined;
    if (!instance_exists(oDialogue)) {
        _inst = instance_create_depth(0, 0, 0, oDialogue);
    } else {
        _inst = oDialogue;
    }
	
    _inst.dialogue_manager.start(name, onFinished);
}