hoveredObject = noone
oldHover = noone
mouseCollider = [oActionButton]
depth = -99

function MouseCheck() {
    oldHover = hoveredObject
    
    // Coordenadas room
    var mx_room = mouse_x
    var my_room = mouse_y
    
    // Coordenadas GUI
    var mx_gui = device_mouse_x_to_gui(0)
    var my_gui = device_mouse_y_to_gui(0)
    
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
        if (variable_instance_exists(hoveredObject, "mouseHover")) {
            hoveredObject.mouseHover()
        }
    }
    
    // ===== Click Left PRESSED (Apertar o botão) =====
    if (mouse_check_button_pressed(mb_left)) {
        if (instance_exists(hoveredObject) and variable_instance_exists(hoveredObject, "buttonPressed")) {
            hoveredObject.buttonPressed()
        }
    }
}