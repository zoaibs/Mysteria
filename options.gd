extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	print(Game.sounds)
	$CheckButton.button_pressed = Game.sounds
	if Game.sounds == true:
		$CheckButton.text = "ON"
	else:
		$CheckButton.text = "OFF"
	$HSlider.value = Game.Hslider


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Game.sounds==true:
		$AudioStreamPlayer2D.volume_db=2
	else:
		$AudioStreamPlayer2D.volume_db=-80


func _on_button_pressed():
	get_tree().change_scene_to_file("res://home_screen.tscn")


func _on_check_button_pressed():
	if Game.sounds == true:
		Game.sounds=false
	else:
		Game.sounds=true
	if Game.sounds == true:
		$CheckButton.text = "ON"
	else:
		$CheckButton.text = "OFF"


func _on_h_slider_drag_ended(value_changed):
	if $HSlider.value ==0:
		Game.lives=999999999
		Game.Hslider=0
	elif $HSlider.value ==1:
		Game.lives=6
		Game.Hslider=1
	elif $HSlider.value ==2:
		Game.lives=4
		Game.Hslider=2
	elif $HSlider.value ==3:
		Game.lives=2
		Game.Hslider=3
	elif $HSlider.value ==4:
		Game.lives=1
		Game.Hslider=4
		
