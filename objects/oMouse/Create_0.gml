hoveredObject = noone
oldHover = noone
mouseCollider = [oActionButton]
depth = -99

function MouseCheck() {
	var mx_room = mouse_x
    var my_room = mouse_y
	
    oldHover = hoveredObject
    hoveredObject = noone

    if (hoveredObject == noone) {
        var inst = instance_place(mx_room, my_room, mouseCollider);
        if (instance_exists(inst))
            hoveredObject = inst
    }
    
    // ===== Hover Exit =====
    if (instance_exists(oldHover) and oldHover != hoveredObject) {
        if (variable_instance_exists(oldHover, "mouseHoverExit"))
            oldHover.mouseHoverExit()
    }
    
    // ===== Hover Enter =====
    if (instance_exists(hoveredObject)) {
        if (variable_instance_exists(hoveredObject, "mouseHover"))
            hoveredObject.mouseHover()
    }
    
    // ===== Click Left PRESSED =====
    if (mouse_check_button_pressed(mb_left)) {
        if (instance_exists(hoveredObject) and variable_instance_exists(hoveredObject, "buttonPressed"))
            hoveredObject.buttonPressed()
    }
}