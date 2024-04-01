extends CharacterBody2D

var first_interaction_happened = false


func _on_area_2d_body_entered(body):
	if body.is_in_group("Player") and !first_interaction_happened:
		
		body.interact_wizard()
		first_interaction_happened = true
	
