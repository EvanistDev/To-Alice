EnemyStatus = {
	name: "",
	hp: 0,
	hpMax: 0,
	damage: 0,
	defense: 0,
	spd: 0,
	atk1Name: "",
	atk2Name: "",
	atk1: fristAttack,
	atk2: SecoundAttack,
	maxAttackCooldown: 0,
	sprite: noone,
	color: noone
}

attackCooldownMax = 50
attackCooldown = attackCooldownMax
ActionTime = false
maxAttack = 0
detectPlayer = 200

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
		spd: 5,
		atk1Name: "Frist",
		atk2Name: "Second",
		maxAttackCooldown: 5
	}
	
	function updateStatus() {
		var _enemy = newEnemyStatus[EnemyType.slimeCommon]
		EnemyStatus.name = _enemy.name
		EnemyStatus.hp = _enemy.hpMax
		EnemyStatus.hpMax = _enemy.hpMax
		EnemyStatus.damage = _enemy.damage
		EnemyStatus.defense = _enemy.defense
		EnemyStatus.color = _enemy.color
		EnemyStatus.spd = _enemy.spd
		EnemyStatus.atk1Name = _enemy.atk1Name
		EnemyStatus.atk2Name = _enemy.atk2Name
		EnemyStatus.maxAttackCooldown = _enemy.maxAttackCooldown
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
		maxAttack += 1
	}
	
	function SecoundAttack() {
		oPlayer.reciveDamage(EnemyStatus.damage * 1.5)
		oCombatSystem.newAction(EnemyStatus.name, EnemyStatus.atk2Name)
	}
#endregion

#region Enemy State
	 enum EnemyState {
		Patrol,
		Chasing, 
		Escaping
	 }
	state = EnemyState.Patrol
	 
	 originX = x
	 originY = x
	 distanceVariableX = 140
	 leftDir = true
	 idleEnemy = false
	 idleCooldown = 0
	 idleMaxCooldown = 200
	 hasReachedLimit = false
	
	 function enemyState() {
		 if (global.inCombat)
			exit
			
		var _dist = distance_to_object(oPlayer)
		switch(state) {
			case EnemyState.Patrol:
				if (x >= originX + distanceVariableX and not hasReachedLimit) {
				    leftDir = true
				    idleEnemy = irandom(100) <= 50
				    hasReachedLimit = true
				}
				else if (x <= originX - distanceVariableX and not hasReachedLimit) {
				    leftDir = false
				    idleEnemy = irandom(100) <= 50
				}

				if (x < originX + distanceVariableX - 10 and x > originX - distanceVariableX + 10)
				    hasReachedLimit = false

				if (not idleEnemy) {
				    if (leftDir)
				        x -= EnemyStatus.spd / 2.5
				    else
				        x += EnemyStatus.spd / 2.5
				} else {
				    if (idleCooldown <= 0) {
				        idleEnemy = false
				        idleCooldown = idleMaxCooldown
				    }
				    idleCooldown--
				}
				break
				
			case EnemyState.Chasing:
				if (_dist <= detectPlayer) {
					var _dir = point_direction(x, y, oPlayer.x, oPlayer.y)
					x += lengthdir_x(EnemyStatus.spd, _dir)
					y += lengthdir_y(EnemyStatus.spd, _dir)
				}
				else 
					state = EnemyState.Patrol	

				if (_dist <= 0)
					room_goto(rCombat)
				break
				
			case EnemyState.Escaping:
				break
		}
	 }
#endregion