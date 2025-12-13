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

status = {
	name: "Alice",
	hp: 100,
	hpMax: 10,
	damage: 20,
	defense: 0,
}

spd = 8 
ActionTime = false

/*Test*/
if (instance_exists(oCombatSystem))
	ActionTime = true

#region Combat Functions
	function reciveDamage(_Damage) {
		status.hp -= abs(_Damage - status.defense)
		
		if (status.hp <= 0)
			die()
	}
	
	function die() {
		
	}

	function fristAttack() {
		oGenericEnemy.reciveDamage(status.damage)
		oCombatSystem.newAction(status.name, "FRIST")
	}

	function SecoundAttack() {
		oGenericEnemy.reciveDamage(status.damage * 2)
		oCombatSystem.newAction(status.name, "SECOUND")
	}
#endregion