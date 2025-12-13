#region Helpers
function draw_slot(x, y)
{
    draw_sprite(slot_sprite, 0, x, y);
}

function draw_item(slot, x, y)
{
    var item_w = sprite_get_width(slot.item.sprite);
    var item_h = sprite_get_height(slot.item.sprite);

    draw_sprite(slot.item.sprite, 0, x - item_w * 0.5, y - item_h * 0.5);
}

function draw_amount(amount, x, y)
{
    if (amount <= 1) return;

    var text_x = x + (INVENTORY_SLOT_SIZE / 2) - INVENTORY_SLOT_COUNT_PADDING; 
    var text_y = y - (INVENTORY_SLOT_SIZE / 2) + INVENTORY_SLOT_COUNT_PADDING;

    draw_set_halign(fa_right);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
    draw_text(text_x, text_y, string(amount));
}
#endregion

if (!showing_inventory) return;

#region DrawBackground
draw_sprite_stretched(
    background_sprite,
    0,
    panel_x,
    panel_y,
    panel_w,
    panel_h
);
#endregion

#region DrawSlots
for (var i = 0; i < slots; i++)
{
    var col = i mod INVENTORY_ROW_LENGTH;
    var row = i div INVENTORY_ROW_LENGTH;

    var slot_x = panel_x + INVENTORY_MARGIN + slot_offset + col * (INVENTORY_SLOT_SIZE + INVENTORY_SLOT_PADDING);
    var slot_y = panel_y + INVENTORY_MARGIN + slot_offset + row * (INVENTORY_SLOT_SIZE + INVENTORY_SLOT_PADDING);

    draw_slot(slot_x, slot_y);

    var slot = global.inventory_manager.get_at(i);
    if (slot.is_empty()) continue;

    if (dragging_slot != i)
    {
        draw_item(slot, slot_x, slot_y);
        draw_amount(slot.amount, slot_x, slot_y);
    }
}
#endregion

#region DrawEquipment
draw_sprite_stretched(
    background_sprite,
    0,
    equip_panel_x,
    equip_panel_y,
    equip_panel_w,
    equip_panel_h
);

var slot_x = equip_panel_x + equip_panel_w * 0.5;
var slot_y = equip_panel_y + INVENTORY_MARGIN + INVENTORY_SLOT_SIZE * 0.5;

for (var i = 0; i < EQUIP_SLOT_COUNT; i++)
{
    var yy = slot_y + i * (INVENTORY_SLOT_SIZE + INVENTORY_SLOT_PADDING);

    draw_slot(slot_x, yy);

    var slot = global.inventory_manager.equipment[i];
    if (!slot.is_empty())
    {
        draw_item(slot, slot_x, yy);
        draw_amount(slot.amount, slot_x, yy);
    }
}

#endregion

#region DrawDragging
if (dragging_slot != -1)
{
    var drag_slot = global.inventory_manager.get_at(dragging_slot);

    var draw_x = mouse_x + drag_offset_x;
    var draw_y = mouse_y + drag_offset_y;

    draw_item(drag_slot, draw_x, draw_y);
    draw_amount(drag_slot.amount, draw_x, draw_y);
}
#endregion

#region HoverHint
if (hovered_slot != -1)
{
    var slot;
    if (hovered_is_equip)
        slot = global.inventory_manager.equipment[hovered_slot];
    else
        slot = global.inventory_manager.get_at(hovered_slot);

    var item = slot.item;

	if (!is_undefined(item)) 
	{
		    var name = item.name;
    var desc = item.description;
	var action = item_type_to_action(item.item_type);
	if (hovered_is_equip) action = "Unequip";

    var padding = 8;
    var max_width = 220;

    draw_set_halign(fa_left);
    draw_set_valign(fa_top);

    var text = name + "\n" + desc;
	if (!is_undefined(action)) text += "\n\n" + "Right Click to " + action;
    var text_w = min(max_width, string_width(text));
    var text_h = string_height(text);

    var bx = mouse_x + 16;
    var by = mouse_y + 16;
    var bw = text_w + padding * 2;
    var bh = text_h + padding * 2;

    draw_set_alpha(0.9);
    draw_set_color(c_black);
    draw_rectangle(bx, by, bx + bw, by + bh, false);

    draw_set_alpha(1);
    draw_set_color(c_white);
    draw_text(bx + padding, by + padding, text);
	}
}
#endregion