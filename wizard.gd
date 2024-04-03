extends CharacterBody2D

var first_interaction_happened = false
var second_interaction_happened=false
var check: Area2D
@onready var teleportSFX = $"../SFX/teleportSFX"
@onready var damageSFX = $"../SFX/damageSFX"

func _on_area_2d_body_entered(body):
	if body.is_in_group("Player") and !first_interaction_happened:
		
		body.interact_wizard()
		first_interaction_happened = true
	
	if body.is_in_group("Player") and !second_interaction_happened and Game.bossBattle:
		body.interact_wizard()
		second_interaction_happened=true
		

	


func _on_area_2d_2_body_entered(body):
	if body.name == "Player" and $".".visible==true and Game.bossBattle:
		body.take_damage()

func _on_area_2d_2_area_entered(area):
	check = area
	print("Check:",check)
	
func _physics_process(delta):
	if check:
		if check.name == "SwordArea":
			if check.get_parent().is_attack():
				Game.bossHP-=20
				if Game.bossHP > 0:
					teleportSFX.play()
				else:
					damageSFX.play()
				check = null

func _process(delta):
	print($".".position.x,", ", $".".position.y)
	if second_interaction_happened:
		if Game.bossHP<=20:
			$".".position.x=78
			$".".position.y=446
		elif Game.bossHP<=40:
			$".".position.x=1186
			$".".position.y=446
		elif Game.bossHP<=60:
			$".".position.x=650
			$".".position.y=252
		elif Game.bossHP<=80:
			$".".position.x=1186
			$".".position.y=446
		elif Game.bossHP<=100:
			$".".position.x=78
			$".".position.y=446
		elif Game.bossHP == 120:
			$".".position.x=650
			$".".position.y=252
		
		if Game.bossHP<=1:
			$".".visible=false
			$".".position.x=4650
			




