function buttonPressed() {
	if (oPlayer.ActionTime) {
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
