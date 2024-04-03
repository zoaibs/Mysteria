extends CharacterBody2D


var attack_check: Area2D
@onready var anim = $AnimationPlayer2
@onready var death_sfx = $"../../SFX/deathSFX"

var speed = 150
var hp = 2
var player_detected = false
@onready var player: CharacterBody2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var current_anim = "idle"
func _physics_process(delta):
	if player_detected:
		print("Player has been detected")
		# Get the player's global position
		var player_position = player.global_position
		if not is_on_floor():
			velocity.y += gravity * delta * 1.1
		# Calculate the direction towards the player
		var direction = sign(player_position - global_position) #.normalized()
		print(direction)
		
		# Set the velocity to move towards the player's x position
		if is_on_floor():
			velocity.x = direction.x * speed  # Adjust 'speed' as needed
		print(velocity.x)
		# Optionally, you can also adjust the Y velocity if you want the monster to move vertically
		# velocity.y = direction.y * speed

		# Optionally, flip the sprite to face the direction of movement
		if direction.x < 0:
			$AnimatedSprite2D2.flip_h = true
		else:
			$AnimatedSprite2D2.flip_h = false
		move_and_slide()
		
	anim.play(current_anim)
	if attack_check:
		if attack_check.name == "SwordArea":
			if attack_check.get_parent().is_attack():
				hp-=1
				if hp==0:
					player.add_score(10)
					death_sfx.play()
					get_parent().remove_child(self)
		





	

#Check if the sword area collides with mcb
func _on_hitbox_area_area_entered(area):
	attack_check = area
	pass # Replace with function body.

#check if 
func _on_hitbox_area_area_exited(area):
	attack_check = null
	pass # Replace with function body.


func _on_player_detect_area_body_entered(body):
	#start following player
	# Check if the entered body is the player
	if body.is_in_group("Player"):
		player_detected = true
		player = body
		
		
#player exits range of troll
func _on_player_detect_area_body_exited(body):
	player_detected = false
	pass # Replace with function body.



func _on_hitbox_area_body_entered(body):
	
	if body.name == "Player":
		body.take_damage()
	pass # Replace with function body.



