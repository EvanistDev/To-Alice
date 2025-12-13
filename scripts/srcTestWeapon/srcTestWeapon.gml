function TestWeapon() : 
BaseEquipmentItem(
	ITEM_ID.TEST_WEAPON, 
	EQUIPMENT_TYPE.WEAPON, 
	sTestWeapon
) constructor {

	self.use = function () {
		show_debug_message("Equiped weapon");	
	};
	
	self.interact = function () {
		show_debug_message("Interacting With Test Weapon");	
	}
}