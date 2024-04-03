extends Node2D

func _ready():
	if Game.sounds == true:
		$AudioStreamPlayer.volume_db = 2
		$SFX/jumpSFX.volume_db=2
		$SFX/attackSFX.volume_db=2
		$SFX/deathSFX.volume_db=2
	else:
		$AudioStreamPlayer.volume_db=-80
		$SFX/jumpSFX.volume_db=-80
		$SFX/attackSFX.volume_db=-80
		$SFX/deathSFX.volume_db=-80

func _process(delta):
	pass
	#if Game.bossBattle:
		#get_tree().change_scene_to_file("res://boss.tscn")
