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

enemyState()
