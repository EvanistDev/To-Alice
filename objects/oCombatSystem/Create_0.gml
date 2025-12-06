#region Turn Settings
	currentTurn = 1
	AuxiliaryTurn = 1
	turnString = "01"
	turnList = [oPlayer, oGenericEnemy]
	turnList[0].ActionTime = true
	
	function turnChange() {
		if ((AuxiliaryTurn - 1) % 2) == 1
			currentTurn++
			
		AuxiliaryTurn++
		turnToAttack = turnList[(AuxiliaryTurn - 1) % 2]
		turnString = currentTurn < 10 ? $"0{currentTurn}" : currentTurn
		oPlayer.ActionTime = false
		oGenericEnemy.ActionTime = false
		turnToAttack.ActionTime = true
	}
	
	function turnIndication() {
		draw_set_colour(c_black)
		draw_text_ext_transformed(room_width / 2, 90, turnString, 15, room_width, 2.4, 2.4, 1)
		
		draw_set_colour(c_white)
		draw_text_ext_transformed(room_width / 2, 90, turnString, 15, room_width, 2, 2, 1)
	}
#endregion

#region Action Indication
	actor = noone
	action = noone
	actionCooldownMAX = 120
	actionCooldown = actionCooldownMAX
	
	function newAction(_ACTOR, _ACTION) {
		actor = _ACTOR
		action = _ACTION
	}

	function actionIndication() {
		if (actor != noone or action != noone) {
			draw_text(room_width / 2, 130, $"{actor}: {action}")
			
			if (actionCooldown <= 0) {
				actor = noone
				action = noone
				actionCooldown = actionCooldownMAX
			} else
				actionCooldown--
		}
	}
#endregion
