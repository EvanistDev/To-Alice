randomize()

#region Dialogue Manager Setup
	global.dialogue_manager = new DialogueManager();
	
	function updateDialogLanguage() {
		var file_path = working_directory + $"/language/{global.current_language}/dialogue.json";
		var file = file_text_open_read(file_path);

		if (file == -1) {
		    show_debug_message("Failed to open dialogue.json at " + file_path);
		} else {
		    var file_text = "";
		    while (!file_text_eof(file)) {
		        file_text += file_text_readln(file); 
		        file_text += "\n";
		    }
		    file_text_close(file);

		    global.dialogue_manager = new DialogueManager();
		    global.dialogue_manager.load_json(file_text);
		}
	}
#endregion

#region Interface Manager Setup
	global.interface_manager = new DialogueManager()
	
function updateInterfaceLanguage() {
    var file_path = working_directory + $"/language/{global.current_language}/interface.json";
    var file = file_text_open_read(file_path);
    
    if (file == -1) {
        show_debug_message("Failed to open interface.json at " + file_path);
    } else {
        var file_text = "";
        while (!file_text_eof(file)) {
            file_text += file_text_readln(file);
            file_text += "\n";
        }
        file_text_close(file);
        
        global.interface_manager = new InterfaceManager()
        global.interface_manager.load_json(file_text)
    }
}
#endregion

languageIndex = 0

#region Combat
	global.inCombat = false
	enemydefeated = []
	enemyBattle = noone
#endregion

#region Save/Load
	function saveGame() {
		var _saveData = {
			player: {
				hp: oPlayer.status.hp
			},
			progress: {
				defeatedEnemy: enemydefeated,
				currentRoom: room
			},
			settings: {
				language: languageIndex
			}
		}
		
		var file = file_text_open_write("savegame.json")
		file_text_write_string(file, json_stringify(_saveData))
		file_text_close(file)
		show_debug_message("Save")
	}
		
	function loadGame() {
		if (not file_exists("savegame.json"))
			return noone
		
		var _file = file_text_open_read("savegame.json")
		var _jsonString = file_text_read_string(_file)
		file_text_close(_file)
		
		var _saveData = json_parse(_jsonString)
		
		/*ADD ---> status Player and last Room*/
		enemydefeated = _saveData.progress.defeatedEnemy
		languageIndex = _saveData.settings.language
	}
	
	if file_exists("savegame.json")
		loadGame()
		
	function deleteSave() {
		file_delete("savegame.json")
	}

#endregion

#region Language 
	enum languageType {
		English,
		Portuguese,
		length 
	}
	global.current_language = ""
	if (not file_exists("savegame.json"))
		languageIndex = languageType.English

	function ChangeLanguage(_languageType) {
		var _language = ["en", "pt-br"]
		global.current_language = _language[_languageType]
		
		updateDialogLanguage()
		updateInterfaceLanguage()

		if instance_exists(oHomeMenu) {	
			if (variable_instance_exists(oHomeMenu, "buttonReferences")) {
				if (array_length(oHomeMenu.buttonReferences) > 0)
					oHomeMenu.updateLanguageButton()
			}
		}
	}
		if languageIndex >= languageType.length
			languageIndex = 0
		ChangeLanguage(languageIndex)
#endregion

function newGame() {
	enemydefeated = []
	enemydefeated = []
}

/*< Initializing instances >*/
instance_create_layer(mouse_x, mouse_y, "Instances", oMouse)
