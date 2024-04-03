extends CharacterBody2D

var first_interaction_happened = false
var check: Area2D

func _on_area_2d_body_entered(body):
	if body.is_in_group("Player") and !first_interaction_happened and !Game.bossBattle:
		
		body.interact_wizard()
		first_interaction_happened = true
		
		

	


func _on_area_2d_2_body_entered(body):
	if body.name == "Player" :
		body.take_damage()

func _on_area_2d_area_entered(area):
		check = area

func _physics_process(delta):
	if check:
		if check.name == "SwordArea":
			if check.get_parent().is_attack():
				Game.bossHP-=1

func _process(delta):
		if Game.bossHP<20:
			$".".position.x=90
		elif Game.bossHP<40:
			$".".position.x=1200
		elif Game.bossHP<60:
			$".".position.x=90
		elif Game.bossHP<80:
			$".".position.x=1200
		elif Game.bossHP<100:
			$".".position.x=90
		elif Game.bossHP == 120:
			$".".position.x=1200
			


