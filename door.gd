extends Node2D




func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		#change scene
		get_tree().change_scene_to_file("res://boss.tscn")
	pass # Replace with function body.
