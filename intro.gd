extends Node2D

func _ready():
	if Game.sounds == true:
		$AudioStreamPlayer.volume_db = 2
	else:
		$AudioStreamPlayer.volume_db=-80

func _process(delta):
	if Game.bossBattle:
		get_tree().change_scene_to_file("res://boss.tscn")
