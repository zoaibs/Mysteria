extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -500.0

@onready var textbox = $Textbox

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var can_move = true

@onready var anim = get_node("AnimationPlayer")
var coyote_time = 0.3
var can_jump = false

var textbox_visible = false


func _physics_process(delta):
	if(textbox_visible):
		textbox.show()
	else:
		textbox.hide()
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if is_on_floor() and can_jump == false:
		can_jump = true
	elif can_jump == true and $CoyoteTimer.is_stopped():
		$CoyoteTimer.start(coyote_time)
		
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and can_jump and can_move:
		velocity.y = JUMP_VELOCITY
		anim.play("jump")
		
	

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction == -1 and can_move:
		get_node("AnimatedSprite2D").flip_h = true
	elif direction == 1 and can_move:
		get_node("AnimatedSprite2D").flip_h = false
	if direction and can_move:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			anim.play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			anim.play("idle")
		#if velocity.y > 0:
			#anim.play("jump")
			
	move_and_slide()

func interact_wizard():
	can_move = false
	textbox_visible = true
	
	#add dialogue scene
	
func _on_coyote_timer_timeout():
	can_jump = false
	pass # Replace with function body.
