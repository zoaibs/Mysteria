extends Node

#If you want to publish game, you should use users instead of res
const SAVE_PATH="res://savegame.bin"

func saveGame():
	var file = FileAccess.open(SAVE_PATH,FileAccess.WRITE)
#DOn't need to write dictionary but this guarentees that variable is dictionary
	var data: Dictionary={
		"lives":Game.lives,
		"sounds":Game.sounds,
	}
	var jstr = JSON.stringify(data)
	file.store_line(jstr)
	
func loadGame():
	var file = FileAccess.open(SAVE_PATH,FileAccess.READ)
	if FileAccess.file_exists(SAVE_PATH)==true:
		if not file.eof_reached():
			var current_line=JSON.parse_string(file.get_line())
			if current_line:
				Game.lives = current_line["lives"]
				Game.sounds = current_line["sounds"]
