extends CharacterBody2D



func _on_area_2d_body_entered(body):
	if body.is_in_group("Player"):
		#print("boii")
		body.set_respawn_position(global_position)
	pass # Replace with function body.
