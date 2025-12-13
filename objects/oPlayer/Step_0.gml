#region Movimentação
	var _eixoX = keyboard_check(ord("D")) - keyboard_check(ord("A"))
	var _eixoY = keyboard_check(ord("S")) - keyboard_check(ord("W"))
	
	var len = _eixoX == 0 and _eixoY == 0 ? 0 : spd
	var dir = point_direction(0, 0, _eixoX, _eixoY)

	var moveDirX = lengthdir_x(len, dir)
	var moveDirY = lengthdir_y(len, dir)
	
	if (not global.inCombat and not global.dialogue_manager.active) {
		x += moveDirX
		y += moveDirY
		
		if (moveDirX != 0) {
			sprite_index = sAliceRun
			image_xscale = scale * sign(moveDirX)
		} else
			sprite_index = sAliceIdle
	} 
#endregion

#region combat Effects
	if (hitShake) {
		hitFlashTimer--
	
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

if (sprite_index == sAliceDying) {
	if (image_index >= image_number) {
		image_speed = 0
		
		if CooldownDie <= 0 {
			/*Fazer voltar ao ultimo save*/
			CooldownDie = maxCooldownDie
			room_goto(rTest)
		}
		CooldownDie--
	}
}