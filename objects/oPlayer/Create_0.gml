global.inventory_manager = new InventoryManager(INVENTORY_SLOTS);

//Test (REMOVE ME)
global.inventory_manager.add(ITEM_ID.HEALTH_POTION);
global.inventory_manager.add(ITEM_ID.HEALTH_POTION, 5);
global.inventory_manager.add(ITEM_ID.TEST_WEAPON);

#region Dialogue Manager Setup
global.dialogue_manager = new DialogueManager();

var file_path = "dialogue.json";
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

#endregion

playerStatus = {
	name: "Eva",
	hp: 10,
	hpMax: 10,
	damage: 2,
	defense: 0,
}

spd = 5  
ActionTime = false

#region Combat Functions
	function reciveDamage(_Damage) {
		playerStatus.hp -= abs(_Damage - playerStatus.defense)
	}

	function fristAttack() {
		oGenericEnemy.reciveDamage(playerStatus.damage)
		oCombatSystem.newAction(playerStatus.name, "Erh...")
	}

	function SecoundAttack() {
		oGenericEnemy.reciveDamage(playerStatus.damage * 1.5)
		oCombatSystem.newAction(playerStatus.name, "FDS")
	}
#endregion