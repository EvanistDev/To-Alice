function buttonPressed() {
	if (oPlayer.ActionTime and not global.dialogue_manager.active and oPlayer.status.hp > 0) {
		switch (choiceAttack) {
			case 0:
				oPlayer.fristAttack()
				break
			case 1:
				oPlayer.SecoundAttack()
				break
		}
		
		oCombatSystem.turnChange()
	}	
}

function mouseHover() {
	image_blend = c_grey
}

function mouseHoverExit() {
	image_blend = c_white
}
