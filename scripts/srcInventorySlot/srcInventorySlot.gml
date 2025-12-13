function InventorySlot(_slot_id, _hold_type) constructor {
	self.hold_type = _hold_type;
	self.item = undefined;
	self.amount = -1;
	self.slot_id = _slot_id;
	
	function is_empty() 
	{
		return is_undefined(self.item);
	}
	
	function is_full() 
	{
		return !is_empty() and self.amount >= self.item.stack_amount;
	}
	
	function update_slot_id(slot_id) 
	{
		self.slot_id = slot_id;
		if (!is_undefined(self.item)) 
		{
			self.item.slot_id = slot_id;
		}
	}
	
	function add(item, amount)  
	{
		if (self.hold_type != ITEM_TYPES.ANY and item.item_type != self.hold_type) return -1;
		
		if (is_undefined(item))
		{
			clear();
			return;
		}
		
		self.item = item;
		self.item.slot_id = self.slot_id;
		self.amount = 0;
		return add_amount(amount);
	}
	
	function add_amount(amount)  
	{
	    if (is_undefined(self.item)) return amount;

	    var max_add = self.item.stack_amount - self.amount;
    
	    if (max_add <= 0) 
	    {
	        return amount;
	    }
    
	    var add_now = min(amount, max_add);
    
	    self.amount += add_now;
    
	    return amount - add_now;
	}
	
	function clear() 
	{
		self.item = undefined;
		self.amount = -1;
	}
	
	function remove(amount = -1)  
	{
		var new_amount = self.amount - amount;
		
		if (amount < 0 || new_amount <= 0) 
		{
			self.clear();
		}
		else 
		{
			self.amount = new_amount;
		}
	}
}