/* Create Sequence */
seq = layer_sequence_create("Instances", 1095, room_height / 2, seqNameAnimation)

#region Buttons
	enum MenuButtons {
		NewGame,
		Continue,
		Options,
		ChangeLanguage
	}
	buttonText = ["new_game", "continue", "options", "change_language"]
	index = 0
	
	buttonReferences = []
	function updateHomeButtons(_button) {
		array_push(buttonReferences, _button)
		var _arrayIndex = array_length(buttonReferences) -1
		var _buttonRef = buttonReferences[_arrayIndex]
		
		_buttonRef.text = global.interface_manager.get_text("menu", buttonText[index])
		_buttonRef.buttonFunction = MenuButtons.NewGame + _arrayIndex
		
		if (index < array_length(buttonText) -1)
			index++
	}
	
	function updateLanguageButton() {
		for (var i = 0; i < array_length(buttonReferences); i++) {
			var _buttonRef = buttonReferences[i]
			_buttonRef.text = global.interface_manager.get_text("menu", buttonText[i])
		}
	}
	
#endregion