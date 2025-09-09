extends CharacterBody2D

var Missile = preload("res://scenes/missile.tscn")

@onready var time_moving = $MovingTimer
@onready var animation_alien = $AnimationAlien
@onready var spawn_point = $spawnPoint

const SPEED = 300.0

func _physics_process(delta: float) -> void:	
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

var origin = 0
var distance = 30
var passo = 7
var direction = 1

signal dead_alien

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
	emit_signal("dead_alien")
	get_parent().remove_child(self)
	queue_free()

func shoot():
	var missile = Missile.instantiate()
	missile.global_position = spawn_point.global_position
	get_parent().add_child(missile)
