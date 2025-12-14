status = {
	name: "Alice",
	hp: 100,
	hpMax: 100,
	damage: 20,
	defense: 0,
}

scale = 3
image_xscale = scale
image_yscale = scale

spd = 8 
ActionTime = false

/*Test*/
if (instance_exists(oCombatSystem))
	ActionTime = true

#region Combat Functions
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
		
		maxCooldownDie = 20
		CooldownDie = maxCooldownDie
		
		if (status.hp <= 0)
			die()
	}
	
	function die() {
		sprite_index = sAliceDying
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