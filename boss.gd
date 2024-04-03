extends Node2D


# Called when the node enters the scene tree for the first time.
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


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
