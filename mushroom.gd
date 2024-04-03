extends CharacterBody2D


var check: Area2D
@onready var anim = $AnimationPlayer2
@onready var death_sfx = $"../../SFX/deathSFX"


func _on_area_2d_area_entered(area):
	print("THIS IA CHANGE")
	check = area
	#print(area.name)
	#if area.name == "SwordArea":
		#print(area.get_parent().is_attack())
		#if area.get_parent().is_attack():
			#print("being attacked")
			#self.get_parent().queue_free()
	pass # Replace with function body.
	


func _physics_process(delta):
	anim.play("idle")
	if check:
		if check.name == "SwordArea":
			if check.get_parent().is_attack():
				death_sfx.play()
				get_parent().remove_child(self)
		


func _on_area_2d_area_exited(area):
	check = null
	pass # Replace with function body.


func _on_area_2d_body_entered(body):

	if body.name == "Player" :
		body.take_damage()
	pass # Replace with function body.
