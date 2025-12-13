randomize()

#region Combat
	global.inCombat = false
	enemydefeated = []
	enemyBattle = noone
#endregion

/*< Initializing instances >*/
instance_create_layer(mouse_x, mouse_y, "Instances", oMouse)
