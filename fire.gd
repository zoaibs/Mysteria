extends Node2D

var rng = RandomNumberGenerator.new()
var fireList= [$"../fire1",$"../fire2",$"../fire3",$"../fire4",$"../fire5",$"../fire6",$"../fire7",$"../fire8"]
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Game.bossHP<100:
		$"../fire1".visible=true
		$"../fire2".visible=true
	if Game.bossHP<80:
		$"../fire3".visible=true
		$"../fire4".visible=true
	if Game.bossHP<60:
		$"../fire5".visible=true
		$"../fire6".visible=true
	if Game.bossHP<40:
		$"../fire7".visible=true
		$"../fire8".visible=true



func _on_area_2d_body_entered(body):
	if body.name == "Player" and self.visible:
		body.take_damage()
