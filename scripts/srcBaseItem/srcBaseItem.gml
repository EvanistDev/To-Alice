function BaseItem(_item_id, _item_type, _stack_amount, _sprite) constructor {
	
	self.item_id = _item_id;
	self.item_type = _item_type;
	self.stack_amount = _stack_amount;
	self.sprite = _sprite;
	self.slot_id = -1;

	self.use = function () 
	{
		show_error("Error: use() must be implemented by the derived struct!", true);	
	}
	
	self.interact = function () 
	{
		show_error("Error: interact() must be implemented by the derived struct!", true);
	}
	
	self.remove_self = function () 
	{
		global.inventory_manager.remove_at(self.slot_id, 1);
	}
}