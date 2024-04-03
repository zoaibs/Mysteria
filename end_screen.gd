extends Node2D

@onready var scoreText = $ScoreText
# Called when the node enters the scene tree for the first time.
func _ready():
	scoreText.text = "Score: " + str(Game.score)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://home_screen.tscn")
	pass # Replace with function body.
