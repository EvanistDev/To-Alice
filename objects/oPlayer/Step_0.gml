#region Movimentação
	var _eixoX = keyboard_check(ord("D")) - keyboard_check(ord("A"))
	var _eixoY = keyboard_check(ord("S")) - keyboard_check(ord("W"))
	
	var len = _eixoX == 0 and _eixoY == 0 ? 0 : spd
	var dir = point_direction(0, 0, _eixoX, _eixoY)

	var moveDirX = lengthdir_x(len, dir)
	var moveDirY = lengthdir_y(len, dir)

	x += moveDirX
	y += moveDirY
#endregion