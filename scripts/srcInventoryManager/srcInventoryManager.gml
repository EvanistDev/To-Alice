function InventoryManager(_inventory_slots) constructor 
{
	self.inventory_slots = _inventory_slots;
	
	self.inventory = [];
	for (var i = 0; i < self.inventory_slots; i++)
	{
	    self.inventory[i] = new InventorySlot(i, ITEM_TYPES.ANY);
	}
	
	if (!instance_exists(oInventory)) {
        _inst = instance_create_depth(0, 0, 0, oInventory);
    } else {
        _inst = oInventory;
    }
	
	function _add_existing(slot_id, amount, item_id) 
	{
		var leftover = -1;
		
		if (item_id != ITEM_ID.NONE) leftover = self.inventory[slot_id].add(make_item(item_id), amount);
		else leftover = self.inventory[slot_id].add_amount(amount);
		
		show_debug_message(leftover);
		
		if (leftover > 0) add(self.inventory[slot_id].item.item_id, leftover);
	}
	
	function _get_item_slot(item_id) 
	{
		for (var i = 0; i < self.inventory_slots; i++) 
		{
			if (is_undefined(self.inventory[i].item)) 
			{
				if (item_id == ITEM_ID.NONE) return i;
				continue;	
			}
			else if (self.inventory[i].item.item_id == item_id) 
			{
				return i;
			}
		}
		
		return -1;
	}
	
	function get(item_id) 
	{
		var slot = _get_item_slot(item_id);
		if (slot == -1) return undefined;
		
		return get_at(slot);
	}
	
	function get_at(slot_id) 
	{
		return self.inventory[slot_id];
	}

	function add(item_id, amount = 1) 
	{
		if (item_id == ITEM_ID.NONE) 
		{
			show_error("Cannot add an item of type none.", false);
			return false;
		}
		
		var slot_id = _get_item_slot(item_id)

		if (slot_id == -1 or self.inventory[slot_id].amount == self.inventory[slot_id].item.stack_amount) 
		{
			slot_id = _get_item_slot(ITEM_ID.NONE);
			if (slot_id == -1) 
			{
				show_error("Cannot add item, no available slots left.", false);
				return false;
			}
			_add_existing(slot_id, amount, item_id);
			return true
		}
		else 
		{
			_add_existing(slot_id, amount, ITEM_ID.NONE);
			return true;
		}
	}
	
	function remove(item_id, amount = -1) 
	{
		var slot_id = _get_item_slot(item_id);
		if (slot_id == -1) return false; 
		
		self.inventory[slot_id].remove(amount);
		return true;
	}
	
	function remove_at(slot_id, amount = -1) 
	{
		if (slot_id < 0 or slot_id >= inventory_slots) 
		{
			show_error("Cannot remove at an slot less than 0 or greater than INVENTORY_SLOTS.", false);
			return false; 
		}
		
		self.inventory[slot_id].remove(amount);
		return true;
	}
}