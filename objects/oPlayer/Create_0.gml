playerStatus = {
	name: "Eva",
	hp: 10,
	hpMax: 10,
	damage: 2,
	defense: 0,
}

spd = 8 
ActionTime = false

#region Combat Functions
	function reciveDamage(_Damage) {
		playerStatus.hp -= abs(_Damage - playerStatus.defense)
	}

	function fristAttack() {
		oGenericEnemy.reciveDamage(playerStatus.damage)
		oCombatSystem.newAction(playerStatus.name, "Erh...")
	}

	function SecoundAttack() {
		oGenericEnemy.reciveDamage(playerStatus.damage * 1.5)
		oCombatSystem.newAction(playerStatus.name, "FDS")
	}
#endregion