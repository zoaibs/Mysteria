extends CharacterBody2D


var attack_check: Area2D


func _physics_process(delta):
	if attack_check:
		if attack_check.name == "SwordArea":
			if attack_check.get_parent().is_attack():
				get_parent().remove_child(self)
		




#Check if Player collides with mob
func _on_area_2d_body_entered(body):
	print(body.name)
	if body.name == "Player":
		body.take_damage()
	pass # Replace with function body.

#Check if the sword area collides with mcb
func _on_hitbox_area_area_entered(area):
	attack_check = area
	pass # Replace with function body.

#check if 
func _on_hitbox_area_area_exited(area):
	attack_check = null
	pass # Replace with function body.
