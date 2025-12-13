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

for (var i = 0; i < slots; i++)
{
	var col = i mod INVENTORY_ROW_LENGTH;
	var row = i div INVENTORY_ROW_LENGTH;

	var slot_x = panel_x + INVENTORY_MARGIN + slot_offset + col * (INVENTORY_SLOT_SIZE + INVENTORY_SLOT_PADDING);
	var slot_y = panel_y + INVENTORY_MARGIN + slot_offset + row * (INVENTORY_SLOT_SIZE + INVENTORY_SLOT_PADDING);

	#region DrawSlot
	draw_sprite(slot_sprite, 0, slot_x, slot_y);
	#endregion

	#region DrawItem
	var slot = global.inventory_manager.get_at(i);
	if (slot.is_empty()) continue;

    var item_w = sprite_get_width(slot.item.sprite);
	var item_h = sprite_get_height(slot.item.sprite);

	draw_sprite(
	    slot.item.sprite,
	    0,
	    slot_x - item_w * 0.5,
	    slot_y - item_h * 0.5
	);
	#endregion
	
	#region DrawAmount
	if (slot.amount > 1)
    {
        var amount_text = string(slot.amount);

        var text_x = slot_x + (INVENTORY_SLOT_SIZE / 2) -  INVENTORY_SLOT_COUNT_PADDING; 
        var text_y = slot_y - (INVENTORY_SLOT_SIZE / 2) +  INVENTORY_SLOT_COUNT_PADDING;

        draw_set_halign(fa_right);
        draw_set_valign(fa_top);
        draw_set_color(c_white);
        draw_text(text_x, text_y, amount_text);
    }
	#endregion
}