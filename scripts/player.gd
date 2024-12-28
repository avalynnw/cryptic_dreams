extends CharacterBody2D

# set player speed

@export var speed = 300.0
@export var jump_velocity = 600.0
@export var gravity = 800


@onready var _animated_sprite = $AnimatedSprite2D

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
		velocity.y = -jump_velocity

	# Get the input direction and handle the movement/deceleration.
	var horizontal_direction = Input.get_axis("move_left", "move_right")
	if horizontal_direction:
		velocity.x = horizontal_direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	if Input.is_action_pressed("move_right"):
		_animated_sprite.play("walking")
		$AnimatedSprite2D.flip_h = false
	elif Input.is_action_pressed("move_left"):
		_animated_sprite.play("walkia")
		$AnimatedSprite2D.flip_h = true
	else:
		_animated_sprite.stop()

	move_and_slide()
	
	print(velocity.y)
