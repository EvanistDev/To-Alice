if (ActionTime and oCombatSystem.actionCooldown == oCombatSystem.actionCooldownMAX) {
	if attackCooldown <= 0 {
		attackCooldown = attackCooldownMax
		if (ATTACKMAX >= 5 or random(100) <= 3) {
			SecoundAttack()
			ATTACKMAX = 0
		} else
			fristAttack()
		oCombatSystem.turnChange()
	} else
		attackCooldown--
}