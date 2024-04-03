extends Node2D

var fireList= [$".",$"../Node2D2",$"../Node2D3"]
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for i in fireList:
		$"../fire1".visible=true


func _on_area_2d_body_entered(body):
	if body.name == "Player" and self.visible:
		body.take_damage()
