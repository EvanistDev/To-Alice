#macro INVENTORY_SLOTS 18
#macro INVENTORY_ROW_LENGTH 6
#macro INVENTORY_MARGIN 6
#macro INVENTORY_SLOT_SIZE sprite_get_width(slot_sprite)
#macro INVENTORY_SLOT_PADDING 12
#macro INVENTORY_SLOT_COUNT_PADDING 4

#macro EQUIP_SLOT_COUNT EQUIPMENT_TYPE.COUNT

background_sprite = sSlime;
slot_sprite = sPlayer;

slots = INVENTORY_SLOTS;
rows  = ((slots - 1) div INVENTORY_ROW_LENGTH) + 1;
slot_offset = INVENTORY_SLOT_SIZE * 0.5;

panel_w = 2 * INVENTORY_MARGIN + INVENTORY_ROW_LENGTH * INVENTORY_SLOT_SIZE + (INVENTORY_ROW_LENGTH - 1) * INVENTORY_SLOT_PADDING;
panel_h = 2 * INVENTORY_MARGIN + rows * INVENTORY_SLOT_SIZE + (rows - 1) * INVENTORY_SLOT_PADDING;

panel_x = (display_get_gui_width()  - panel_w) * 0.5;
panel_y = (display_get_gui_height() - panel_h) * 0.5;

equip_panel_w = INVENTORY_SLOT_SIZE + INVENTORY_MARGIN * 2;
equip_panel_h =
    EQUIP_SLOT_COUNT * INVENTORY_SLOT_SIZE +
    (EQUIP_SLOT_COUNT - 1) * INVENTORY_SLOT_PADDING +
    INVENTORY_MARGIN * 2;

equip_panel_x = panel_x + panel_w + 32;
equip_panel_y = panel_y + panel_h * 0.5 - equip_panel_h * 0.5;

open_key = "I";
showing_inventory = false;

dragging_slot = -1;
drag_offset_x = 0;
drag_offset_y = 0;

hovered_slot = -1;
hovered_is_equip = false;