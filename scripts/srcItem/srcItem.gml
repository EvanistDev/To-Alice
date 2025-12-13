enum ITEM_TYPES
{
	ANY,
	COLLECTIBLES,
	CONSUMABLES,
	EQUIPMENT
}


enum ITEM_ID
{
	NONE,
	HEALTH_POTION
}


function make_item(_id)
{
	switch (_id)
	{
		case ITEM_ID.HEALTH_POTION:
			return new HealthPotion();
	}
}