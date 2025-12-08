status = {
	name: "Alice",
	hp: 100,
	hpMax: 10,
	damage: 20,
	defense: 0,
}

spd = 8 
ActionTime = false

/*Test*/
if (instance_exists(oCombatSystem))
	ActionTime = true

#region Combat Functions
	function reciveDamage(_Damage) {
		status.hp -= abs(_Damage - status.defense)
		
		if (status.hp <= 0)
			die()
	}
	
	function die() {
		
	}

	function fristAttack() {
		oGenericEnemy.reciveDamage(status.damage)
		oCombatSystem.newAction(status.name, "FRIST")
	}

	function SecoundAttack() {
		oGenericEnemy.reciveDamage(status.damage * 2)
		oCombatSystem.newAction(status.name, "SECOUND")
	}
#endregion