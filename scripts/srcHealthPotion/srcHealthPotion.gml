function HealthPotion() : 
BaseItem(
	ITEM_ID.HEALTH_POTION, 
	ITEM_TYPES.CONSUMABLES, 
	4,
	sTestItem
) constructor {

	self.use = function () {
		show_debug_message("Using Health Potion");	
		self.remove_self();
	};
	
	self.interact = function () {
		show_debug_message("Interacting With Health Potion");	
	}
}