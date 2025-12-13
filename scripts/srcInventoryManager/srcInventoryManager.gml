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
			else if (self.inventory[i].item.item_id == item_id && !self.inventory[i].is_full()) 
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
			show_error("Cannot remove at an slot less than 0 or greater than or equal to INVENTORY_SLOTS.", false);
			return false; 
		}
		
		self.inventory[slot_id].remove(amount);
		return true;
	}
	
	function swap_slots(slot_from_id, slot_to_id) 
	{
	    if (
	        slot_from_id < 0 or
	        slot_from_id >= self.inventory_slots or 
	        slot_to_id < 0 or 
	        slot_to_id >= self.inventory_slots
	    ) 
	    {
	        show_error("Cannot swap from and/or to a slot less than 0 or greater than or equal to INVENTORY_SLOTS.", false);
	        return false;
	    }

	    var slot_from = self.inventory[slot_from_id];
	    var slot_to = self.inventory[slot_to_id];
		
		if (slot_to.hold_type != ITEM_TYPES.ANY and slot_from.hold_type != slot_to.hold_type) 
		{
			return false;
		}

	    if (!slot_from.is_empty() && !slot_to.is_empty() &&
	        slot_from.item.item_id == slot_to.item.item_id)
	    {
	        var total_amount = slot_from.amount + slot_to.amount;
	        var max_stack = slot_from.item.stack_amount;

	        slot_to.amount = min(total_amount, max_stack);
	        slot_from.amount = max(0, total_amount - max_stack);

	        if (slot_from.amount <= 0)
	            self.inventory[slot_from_id] = new InventorySlot(slot_from_id, ITEM_TYPES.ANY);
	    }
	    else
	    {
	        var temp = self.inventory[slot_from_id];
	        self.inventory[slot_from_id] = self.inventory[slot_to_id];
	        self.inventory[slot_to_id] = temp;
	    }

	    self.inventory[slot_to_id].update_slot_id(slot_to_id);
	    self.inventory[slot_from_id].update_slot_id(slot_from_id);

	    return true;
	}
}