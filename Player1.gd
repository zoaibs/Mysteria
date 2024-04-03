extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -550.0

@onready var textbox = $Textbox2
@onready var Endtextbox = $Textbox
@onready var bossHP = $bossHP
@onready var sword = $"../Sword"
@onready var lives_text = $LivesText
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var can_move = true
var sword_offset = Vector2(-30, -10)  # Offset for positioning the sword below the player
var respawn_position = Vector2.ZERO
var is_climbing = false
var lives = Game.lives
var numRuns=0
var picked_sword = false

@onready var jump_sfx = $"../SFX/jumpSFX"



@onready var anim = get_node("AnimationPlayer")

var coyote_time = 0.3
var can_jump = false

var textbox_visible = false
var Endtextbox_visible = false

var direction = 0  # Define direction as a class member variable

func _physics_process(delta):
	if Game.Hslider==0:
		lives_text.text = "Lives: Infinite"
	else:
		lives_text.text = "Lives: " + str(lives)
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider().name == "obstacles":
			respawn_player()
		if Input.is_action_pressed("climb"):
			if collision.get_collider().name == "ladders":
			
				is_climbing = true

				velocity.y = -150
			if Input.is_action_just_released("climb"):

				is_climbing = false
				velocity.y = 0
	if get_slide_collision_count() == 0: 
		is_climbing = false
	

	
	
	if(textbox_visible):
		textbox.show()
	else:
		textbox.hide()
	
	if(Endtextbox_visible):
		Endtextbox.show()
	else:
		Endtextbox.hide()
	
	#creating boss health bar

	if numRuns<1:
		if Game.bossBattle:
			#await get_tree().create_timer(1.2).timeout
			bossHP.visible=true
			#await get_tree().create_timer(.8).timeout
			while Game.bossHP<120:
				#bossHP.value+=1
				Game.bossHP+=1
				#await get_tree().create_timer(1).timeout
			#await get_tree().create_timer(6).timeout
			numRuns+=2
	$bossHP.value=Game.bossHP

		#Game.bossBattle=false
	
	# Add the gravity.
	if not is_on_floor() and !is_climbing:
		
		velocity.y += gravity * delta * 1.1
	
	if is_on_floor() and can_jump == false:
		can_jump = true
	elif can_jump == true and $CoyoteTimer.is_stopped():
		$CoyoteTimer.start(coyote_time)
		
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and can_jump and can_move:
		velocity.y = JUMP_VELOCITY
		anim.play("jump")
		jump_sfx.play()
		
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	if direction == -1 and can_move:
		get_node("AnimatedSprite2D").flip_h = true
		if picked_sword:
			sword.get_node("AnimatedSprite2D").flip_h = true
			sword.rotation_degrees = -20
			sword_offset = Vector2(-64, 3)  # Offset for positioning the sword below the player
		
	elif direction == 1 and can_move: #moving right
		get_node("AnimatedSprite2D").flip_h = false
		if picked_sword:
			sword.get_node("AnimatedSprite2D").flip_h = false
			sword.rotation_degrees = 20
			sword_offset = Vector2(30, -10)  # Offset for positioning the sword below the player
	if abs(direction) > 0 and can_move:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			anim.play("walk")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			anim.play("idle")
			
	move_and_slide()

func interact_wizard():
	can_move = false
	textbox_visible = true
	
	# Add dialogue scene

func _on_coyote_timer_timeout():
	can_jump = false
	pass  # Replace with function body.

# Function to set the respawn position
func set_respawn_position(pos: Vector2):
	respawn_position = pos

# Example of how to respawn the player
func respawn_player():
	lives = Game.lives
	global_position = respawn_position
	
func take_damage():
	
	lives = lives - 1
	if lives == 0:
		respawn_player()
		

