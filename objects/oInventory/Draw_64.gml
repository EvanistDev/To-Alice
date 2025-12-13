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

    draw_slot(slot_x, slot_y);

    var slot = global.inventory_manager.get_at(i);
    if (slot.is_empty()) continue;

    if (dragging_slot != i)
    {
        draw_item(slot, slot_x, slot_y);
        draw_amount(slot.amount, slot_x, slot_y);
    }
}

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