extends CharacterBody2D

@export var laser = preload("res://scenes/laser.tscn")
@onready var ptoLaser = $laser_marker

var direction = Vector2()
const SPEED = 100.0
const JUMP_VELOCITY = -400.0

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
func _physics_process(delta: float) -> void:
	direction = Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x,0,SPEED)
		
	if Input.is_action_just_pressed("shoot"):
		var l = laser.instantiate()
		l.global_position = self.global_position
		get_parent().add_child(l)
		
	move_and_slide()

	# Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta

	# Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
