extends Node2D

func _ready():
	if Game.sounds == true:
		$AudioStreamPlayer.volume_db = 2
	else:
		$AudioStreamPlayer.volume_db=-80

