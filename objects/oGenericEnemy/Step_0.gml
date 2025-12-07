#region attack combat
	if (ActionTime and oCombatSystem.actionCooldown == oCombatSystem.actionCooldownMAX and global.inCombat) {
		if (attackCooldown <= 0) {
			attackCooldown = attackCooldownMax
		
			if (maxAttack > EnemyStatus.maxAttackCooldown -1 or irandom(100) <= 15) {
				SecoundAttack()
				maxAttack = 0
			} else
				fristAttack()
			
			oCombatSystem.turnChange()
		} else
			attackCooldown--
	}
#endregion

enemyState()
