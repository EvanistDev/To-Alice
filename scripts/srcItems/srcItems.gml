enum ITEM_TYPES
{
	ANY,
	COLLECTIBLES,
	CONSUMABLES,
	EQUIPMENT,
	
	COUNT
}

enum ITEM_ID
{
	NONE,
	/*Potions*/
	HEALTH_POTION,
	/*Weapons*/
	TEST_WEAPON,
	
	COUNT
}

enum EQUIPMENT_TYPE 
{
	HELMAT,
	ARMOR,
	WEAPON,
	SHIELD,
	
	COUNT
}

function make_item(_id)
{
	switch (_id)
	{
		case ITEM_ID.HEALTH_POTION:
			return new HealthPotion();
		case ITEM_ID.TEST_WEAPON:
		return new TestWeapon();
	}
}