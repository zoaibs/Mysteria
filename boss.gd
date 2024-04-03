extends Node2D

var end_sound_start=false
var n=0
# Called when the node enters the scene tree for the first time.
func _ready():
	if Game.sounds == true:
		$AudioStreamPlayer.volume_db = 0
		$SFX/jumpSFX.volume_db=2
		$SFX/attackSFX.volume_db=2
		$SFX/deathSFX.volume_db=2
		$SFX/damageSFX.volume_db=2
		$SFX/teleportSFX.volume_db=2
	else:
		$AudioStreamPlayer.volume_db=-80
		$SFX/jumpSFX.volume_db=-80
		$SFX/attackSFX.volume_db=-80
		$SFX/deathSFX.volume_db=-80
		$SFX/damageSFX.volume_db=-80
		$SFX/teleportSFX.volume_db=-80


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Game.bossHP<=1 and n<1:
		end_sound_start=true
		n+=10
	if end_sound_start:
		$AudioStreamPlayer.playing=false
		$AudioStreamPlayer2.playing=true
		end_sound_start=false
