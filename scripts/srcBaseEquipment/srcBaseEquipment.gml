function BaseEquipment(_item_id, _name, _description, _equipment_type, _sprite) : BaseItem(
	_item_id, 
	_name,
	_description,
	ITEM_TYPES.EQUIPMENT, 
	1,
	_sprite
) constructor 
{
	self.equipment_type = _equipment_type;
}