extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -450
@onready var animated_sprite_2d = $AnimatedSprite2D



# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	var can_doubblejump = false
	if (velocity.x > 1 || velocity.x < -1):
		animated_sprite_2d.animation = "running"
	else:
		animated_sprite_2d.animation = "default"	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		animated_sprite_2d.animation = "jump"
		can_doubblejump = true
		
		
	if can_doubblejump and Input.is_action_just_pressed("jump") and not is_on_floor():
		velocity.y += JUMP_VELOCITY
		can_doubblejump = false
		#animated_sprite_2d.animation = "DoubbleJump"
	
		
	if velocity.y >= 1:
		animated_sprite_2d.animation = "falling"
	
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		
		velocity.y = JUMP_VELOCITY
		
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 16)
	
	
		

	move_and_slide()
	
	var isLeft = velocity.x < 0
	animated_sprite_2d.flip_h = isLeft
		
