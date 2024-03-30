extends CharacterBody2D


var player: Node2D  # Reference to the player node


@onready var sword_anim = get_node("AnimationPlayer")

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		player = body
		
		set_process(true)  # Enable _process callback to update position
		pass # Replace with function body.
		
func _process(delta):
	if player:
		#sword_anim.play("idle")
		global_position = player.global_position + player.sword_offset  # Set sword position to player position
		if Input.is_action_just_pressed("attack"):
			
			sword_anim.play("swing")
			

