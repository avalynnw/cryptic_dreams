extends CharacterBody2D

# set player speed
@export var SPEED = 300.0
@export var JUMP_VELOCITY = 300.0
@export var gravity = 300


# Get the gravity from the project settings to be synced with RigidBody nodes.
#@export var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Add the gravity
	if not is_on_floor():
		velocity.y += gravity * delta
		# set max velocity
		if velocity.y > 1000:
			velocity.y = 1000
	# Handle jump.
	# && is_on_floor()
	if Input.is_action_just_pressed("jump") && is_on_floor():
		velocity.y = -JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var horizontal_direction = Input.get_axis("move_left", "move_right")
	if horizontal_direction:
		velocity.x = horizontal_direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
	print(velocity.y)
