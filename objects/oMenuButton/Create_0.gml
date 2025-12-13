function buttonPressed() {
	if (not enable)
		return 
		
	switch (buttonFunction) {
		case MenuButtons.NewGame:
			NewGame()
			break
		case MenuButtons.Continue:
			Continue()
			break
		case MenuButtons.Options:
			Options()
			break
		case MenuButtons.ChangeLanguage:
			GAMECONTROLLER.languageIndex++
			var _indexLanguage = GAMECONTROLLER.languageIndex % languageType.length
			GAMECONTROLLER.ChangeLanguage(_indexLanguage)
			break
	}
}

function mouseHover() {
	if (enable)
		image_blend = c_grey
}

function mouseHoverExit() {
	if (enable)
		image_blend = c_white
}

enable = true
text = ""
buttonFunction = noone
oHomeMenu.updateHomeButtons(self)

if (buttonFunction == MenuButtons.Continue and not file_exists("savegame.json")) {
	image_blend = #3e3d3d
	enable = false
}

if (buttonFunction == MenuButtons.Options) {
	image_blend = #3e3d3d
	enable = false
}

function NewGame() {
	GAMECONTROLLER.newGame()
	room_goto(rTest)
}

function Continue() {
	room_goto(rTest)
}

function Options() {

}
