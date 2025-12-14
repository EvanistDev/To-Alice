#region Turn Settings
	currentTurn = 1
	AuxiliaryTurn = 1
	turnString = "01"
	turnList = [oPlayer, oGenericEnemy]
	turnList[0].ActionTime = true
	turnIndex = 0
	
	/* Create Sequence indicator*/
	seq = layer_sequence_create("Instances", room_width / 2, room_height / 2, seqIndicator)
	
	function turnChange() {
		if ((AuxiliaryTurn - 1) % 2) == 1
			currentTurn++
			
		AuxiliaryTurn++
		turnIndex = (AuxiliaryTurn - 1) % 2
		turnToAttack = turnList[turnIndex]
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
		
		layer_sequence_x(seq, turnList[turnIndex].x)
		layer_sequence_y(seq, turnList[turnIndex].y - turnList[turnIndex].sprite_height / 1.5)
		
		layer_sequence_xscale(seq, 2)
		layer_sequence_yscale(seq, 2)
	}
	
	function turnInitialization() {
		/*Dialog start combat*/
		var chooseDialog = choose("CombatStart1", "CombatStart2", "CombatStart3", "CombatStart4", "CombatStart5")
		create_dialogue(chooseDialog, function() {
	    show_debug_message("Dialogue finished!");
		});
	}
	turnInitialization()
	
#endregion

#region Action Indication
	actor = noone
	action = noone
	actionCooldownMAX = 40
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
