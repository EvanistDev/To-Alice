if (keyboard_check_pressed(ord(open_key)))
{
    showing_inventory = !showing_inventory;
}

if (!showing_inventory) return;

var mx = mouse_x;
var my = mouse_y;

if (mouse_check_button_pressed(mb_left)) 
{
	for (var i = 0; i < slots; i++)
	{
	    var col = i mod INVENTORY_ROW_LENGTH;
	    var row = i div INVENTORY_ROW_LENGTH;

	    var slot_x = panel_x + INVENTORY_MARGIN + slot_offset + col * (INVENTORY_SLOT_SIZE + INVENTORY_SLOT_PADDING);
	    var slot_y = panel_y + INVENTORY_MARGIN + slot_offset + row * (INVENTORY_SLOT_SIZE + INVENTORY_SLOT_PADDING);

	    if (mx > slot_x - INVENTORY_SLOT_SIZE/2 &&
	        mx < slot_x + INVENTORY_SLOT_SIZE/2 &&
	        my > slot_y - INVENTORY_SLOT_SIZE/2 &&
	        my < slot_y + INVENTORY_SLOT_SIZE/2)
	    {
	        var slot = global.inventory_manager.get_at(i);
	        if (!slot.is_empty())
	        {
	            slot.item.use();
	        }
	    }
	}
}