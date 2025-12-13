status = {
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

iid = id
attackCooldownMax = 30
attackCooldown = attackCooldownMax
ActionTime = false
maxAttack = 0
detectPlayer = 200
escape = false

for (var i = 0; i < array_length(GAMECONTROLLER.enemydefeated); i++) {
	var _defeated = GAMECONTROLLER.enemydefeated[i]
	if (variable_instance_exists(self, "iid")) {
		if (_defeated.iid == id) {
			instance_destroy()
			break
		}
	}
}

#region Enemy Type
	enum EnemyType {
		slimeCommon,
		slimeFast,
		slimeResistant,
		snowman,
	}
	
	newstatus = []
	
	newstatus[EnemyType.slimeCommon] = {
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
	
	function updateStatus(_EnemyType) {
		var _enemy = newstatus[_EnemyType]
		status.name = _enemy.name
		status.hp = _enemy.hpMax
		status.hpMax = _enemy.hpMax
		status.damage = _enemy.damage
		status.defense = _enemy.defense
		status.color = _enemy.color
		status.spd = _enemy.spd
		status.atk1Name = _enemy.atk1Name
		status.atk2Name = _enemy.atk2Name
		status.maxAttackCooldown = _enemy.maxAttackCooldown
	}
	
	if (Type != noone) { updateStatus(Type) }
	else { updateStatus(GAMECONTROLLER.enemyBattle.Type) }
#endregion

#region Combat 
	hitShake = false
	hitShakeTime = 0
	hitshakeDuration = 10
	hitShakeIntensity = 4
	originalX = x
	originalY = y
	
	hitFlash = false
	hitFlashTimer = 0
	hitFlashDuration = 4
	
	showDamage = false
	damageValue = 0
	damageY = 0
	damageAlpha = 0
	damageTimer = 0
	damageDuration = 60
	
	function reciveDamage(_Damage) {
		finalDamage = abs(_Damage - status.defense)
		status.hp -= finalDamage
		
		/* Shake */
		hitShake = true
		hitShakeTime = hitFlashDuration
		originalX = x
		originalY = y
		
		/* Flash */
		hitFlash = true
		hitFlashTimer = hitFlashDuration
		
		/* Popup de Damage */
		showDamage = true
		damageValue = finalDamage
		damageY = y - 30
		damageAlpha = 1
		damageTimer = damageDuration

		if (status.hp <= 0)
			die()
	}
	
	function die() {
		array_push(GAMECONTROLLER.enemydefeated, GAMECONTROLLER.enemyBattle)
		room_goto(rTest)
	}

	function fristAttack() {
		oPlayer.reciveDamage(status.damage)
		oCombatSystem.newAction(status.name, status.atk1Name)
		maxAttack += 1
	}
	
	function SecoundAttack() {
		oPlayer.reciveDamage(status.damage * 1.5)
		oCombatSystem.newAction(status.name, status.atk2Name)
	}
#endregion

#region Enemy State
	enum EnemyState {
	    Patrol,
	    Chasing, 
	    Escaping
	}
	state = EnemyState.Patrol

	distanceVariableX = 140
	leftDir = true
	idleEnemy = false
	idleCooldown = 0
	idleMaxCooldown = 200

	detectionCooldown = 0
	detectionCooldownMax = 120
	alertDistance = detectPlayer / 2.5 

	function enemyState() {
	    if (global.inCombat)
	        exit
    
	    if (detectionCooldown > 0)
	        detectionCooldown--
        
	    var _dist = distance_to_object(oPlayer)
	    var _idlechance = 60
    
	    var _alertDetection = (_dist <= alertDistance)
	    var _normalDetection = (_dist <= detectPlayer and detectionCooldown <= 0)
    
	    switch(state) {
	        case EnemyState.Patrol:
	            if (x >= originalX + distanceVariableX) {
	                leftDir = true
	                idleEnemy = irandom(100) <= _idlechance
	            }
	            else if (x <= originalX - distanceVariableX) {
	                leftDir = false
	                idleEnemy = irandom(100) <= _idlechance
	            }
            
	            if (_alertDetection or _normalDetection)
	                state = escape ? EnemyState.Escaping : EnemyState.Chasing
            
	            if (not idleEnemy) {
	                x += leftDir ? -status.spd / 2.5 : status.spd / 2.5
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
	                x += lengthdir_x(status.spd, _dir)
	                y += lengthdir_y(status.spd, _dir)
	            } else {
	                originalX = x
	                state = EnemyState.Patrol
	                detectionCooldown = detectionCooldownMax
	            }
            
	            if (_dist <= 0) {
					GAMECONTROLLER.enemyBattle = self
	                room_goto(rCombat)
				}
	            break
            
	        case EnemyState.Escaping:
	            if (_dist <= detectPlayer) {
	                var _dir = point_direction(x, y, oPlayer.x, oPlayer.y)
	                x -= lengthdir_x(status.spd / 1.2, _dir)
	                y -= lengthdir_y(status.spd / 1.2, _dir)
	            } else {
	                originalX = x
	                state = EnemyState.Patrol
	                detectionCooldown = detectionCooldownMax
	            }
            
	            if (_dist <= 0) {
					GAMECONTROLLER.enemyBattle = self
	                room_goto(rCombat)
				}
	            break
	    }
	}
#endregion