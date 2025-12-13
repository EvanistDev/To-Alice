#region Helpers
function get_slot_position(slot_index)
{
    var col = slot_index mod INVENTORY_ROW_LENGTH;
    var row = slot_index div INVENTORY_ROW_LENGTH;

    var xx = panel_x + INVENTORY_MARGIN + slot_offset + col * (INVENTORY_SLOT_SIZE + INVENTORY_SLOT_PADDING);
    var yy = panel_y + INVENTORY_MARGIN + slot_offset + row * (INVENTORY_SLOT_SIZE + INVENTORY_SLOT_PADDING);

    return [xx, yy];
}

function get_equipment_slot_position(slot_index)
{
    var col = slot_index mod INVENTORY_ROW_LENGTH;
    var row = slot_index div INVENTORY_ROW_LENGTH;

	var slot_y = equip_panel_y + INVENTORY_MARGIN + INVENTORY_SLOT_SIZE * 0.5;

    var yy = slot_y + slot_index * (INVENTORY_SLOT_SIZE + INVENTORY_SLOT_PADDING);
	var xx = equip_panel_x + equip_panel_w * 0.5;
	
    return [xx, yy];
}


function get_slot_under_mouse(mx, my, get_position)
{
    for (var i = 0; i < slots; i++)
    {
        var pos = get_position(i);
        var slot_x = pos[0];
        var slot_y = pos[1];

        if (mx > slot_x - INVENTORY_SLOT_SIZE/2 &&
            mx < slot_x + INVENTORY_SLOT_SIZE/2 &&
            my > slot_y - INVENTORY_SLOT_SIZE/2 &&
            my < slot_y + INVENTORY_SLOT_SIZE/2)
        {
            return i;
        }
    }
    return -1;
}
#endregion

if (keyboard_check_pressed(ord(open_key)))
{
    showing_inventory = !showing_inventory;
}

if (!showing_inventory) return;

var mx = mouse_x;
var my = mouse_y;

#region Hover
hovered_slot = -1;
hovered_is_equip = false;

var idx = get_slot_under_mouse(mx, my, get_slot_position);
if (idx != -1)
{
    var slot = global.inventory_manager.get_at(idx);
    if (!slot.is_empty())
    {
        hovered_slot = idx;
        hovered_is_equip = false;
    }
}

if (hovered_slot == -1)
{
    var eidx = get_slot_under_mouse(mx, my, get_equipment_slot_position);
    if (eidx != -1)
    {
        var eslot = global.inventory_manager.equipment[eidx];
        if (!eslot.is_empty())
        {
            hovered_slot = eidx;
            hovered_is_equip = true;
        }
    }
}
#endregion

#region CheckForUse
if (mouse_check_button_pressed(mb_right))
{
    var slot_idx = get_slot_under_mouse(mx, my, get_slot_position);
    if (slot_idx != -1)
    {
        var slot = global.inventory_manager.get_at(slot_idx);
        if (!slot.is_empty())
            slot.item.use();
    }
	
	var equip_idx = get_slot_under_mouse(mx, my, get_equipment_slot_position);
	if (equip_idx != -1) 
	{
		global.inventory_manager.unequip_item(equip_idx);
	}
}
#endregion

#region Dragging
if (mouse_check_button_pressed(mb_left) && dragging_slot == -1)
{
    var slot_idx = get_slot_under_mouse(mx, my, get_slot_position);
    if (slot_idx != -1)
    {
        var slot = global.inventory_manager.get_at(slot_idx);
        if (!slot.is_empty())
        {
            dragging_slot = slot_idx;
            var pos = get_slot_position(slot_idx);
            drag_offset_x = pos[0] - mx;
            drag_offset_y = pos[1] - my;
        }
    }
}

if (dragging_slot != -1 && mouse_check_button_released(mb_left))
{
    var target_slot = get_slot_under_mouse(mx, my, get_slot_position);
    if (target_slot != -1 && target_slot != dragging_slot)
    {
        global.inventory_manager.swap_slots(dragging_slot, target_slot);
    }
	
    dragging_slot = -1;
}
#endregion