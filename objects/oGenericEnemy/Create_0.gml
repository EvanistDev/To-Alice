EnemyStatus = {
	name: "",
	hp: 0,
	hpMax: 0,
	damage: 0,
	defense: 0,
	atk1Name: "",
	atk2Name: "",
	atk1: fristAttack,
	atk2: SecoundAttack,
	sprite: noone,
	color: noone
}

attackCooldownMax = 50
attackCooldown = attackCooldownMax
ActionTime = false
ATTACKMAX = 0

#region Enemy Type
	enum EnemyType {
		slimeCommon,
		slimeFast,
		slimeResistant,
		snowman,
	}
	
	newEnemyStatus = []
	
	newEnemyStatus[EnemyType.slimeCommon] = {
		name: "Slime Common",
		hpMax: 100,
		damage: 10,
		defense: 5,
		color: $3FC78D,
		atk1Name: "Frist",
		atk2Name: "Second"
	}
	
	function updateStatus() {
		var _enemy = newEnemyStatus[EnemyType.slimeCommon]
		EnemyStatus.name = _enemy.name
		EnemyStatus.hp = _enemy.hpMax
		EnemyStatus.hpMax = _enemy.hpMax
		EnemyStatus.damage = _enemy.damage
		EnemyStatus.defense = _enemy.defense
		EnemyStatus.color = _enemy.color
		EnemyStatus.atk1Name = _enemy.atk1Name
		EnemyStatus.atk2Name = _enemy.atk2Name
	}
	 updateStatus()
#endregion

#region Combat Functions
	function reciveDamage(_Damage) {
		EnemyStatus.hp -= abs(_Damage - EnemyStatus.defense)
	}

	function fristAttack() {
		oPlayer.reciveDamage(EnemyStatus.damage)
		oCombatSystem.newAction(EnemyStatus.name, EnemyStatus.atk1Name)
		ATTACKMAX += 1
	}
	
	function SecoundAttack() {
		oPlayer.reciveDamage(EnemyStatus.damage * 1.5)
		oCombatSystem.newAction(EnemyStatus.name, EnemyStatus.atk2Name)
	}
#endregion