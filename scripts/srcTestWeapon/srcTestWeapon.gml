function TestWeapon() : 
BaseEquipment(
	ITEM_ID.TEST_WEAPON, 
	"Cool Weapon",
	"It can be equiped.",
	EQUIPMENT_TYPE.WEAPON, 
	sTestWeapon
) constructor {

	self.use = function () {
		show_debug_message("Equiped weapon");	
		global.inventory_manager.equip_item(self.slot_id, self.equipment_type);
	};
	
	self.interact = function () {
		show_debug_message("Interacting With Test Weapon");	
	}
}