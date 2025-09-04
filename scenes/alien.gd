extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump. 	 	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

@onready var time_moving = $MovingTimer
@onready var animation_alien = $AnimationPlayer

var origin = 0
var distance = 30
var passo = 7
var direction = 1

func _ready():
	time_moving.start()
	origin = self.position.x

func _on_moving_timer_timeout() -> void:
	self.position.x += direction * passo
	if self.position.x >= origin + distance or self.position.x <= origin - distance:
		direction *= -1
		
func explosion():
	animation_alien.play("destroy")
	print("explosion")
	
func elimination():
	get_parent().remove_child(self)
	queue_free()
