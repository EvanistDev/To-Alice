function BaseEquipmentItem(_item_id, _equipment_type, _sprite) : BaseItem(
	_item_id, 
	ITEM_TYPES.EQUIPMENT, 
	1,
	_sprite
) constructor 
{
	
	self.eequipment_type = _equipment_type;
}