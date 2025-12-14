#region attack combat
	if (global.inCombat) {
		if (ActionTime and oCombatSystem.actionCooldown == oCombatSystem.actionCooldownMAX) {
			if (attackCooldown <= 0) {
				attackCooldown = attackCooldownMax
		
				if (maxAttack > status.maxAttackCooldown -1 or irandom(100) <= 30) {
					SecoundAttack()
					maxAttack = 0
				} else
					fristAttack()
			
				oCombatSystem.turnChange()
			} else
				attackCooldown--
		}
	}
#endregion

#region combat Effects
	if (hitShake) {
		hitShakeTime--
		
		x = originalX + random_range(-hitShakeIntensity, hitShakeIntensity)
		y = originalY + random_range(-hitShakeIntensity, hitShakeIntensity)
		hitShakeIntensity = lerp(hitShakeIntensity, 0, 0.15)
		
	
		if (hitShakeTime <= 0) {
			hitShake = false
			x = originalX
			y = originalY
		}
	}

	if (hitFlash) {
		hitFlashTimer--
		if (hitFlashTimer <= 0 )
			hitFlash = false
	}
	
	if (showDamage) {
		damageTimer--
		damageY -= 1.5  
		damageAlpha = damageTimer / damageDuration  // Fade out
			
		if (damageTimer <= 0)
			showDamage = false
		}
#endregion

enemyState()
