extends CharacterBody2D

@export var laser = preload("res://scenes/laser.tscn")

@onready var ptoLaser = $LaserMarker
@onready var timer_shoot = $ShootTimer
@onready var animation_player = $AnimationPlayer

const SPEED = 100.0

var direction = Vector2()
var can_shoot = true

func _physics_process(delta) -> void:
	direction = Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x,0,SPEED)
		
	if Input.is_action_just_pressed("shoot") and can_shoot == true:
		var l = laser.instantiate()
		l.global_position = ptoLaser.global_position
		get_parent().add_child(l)
		can_shoot = false
		timer_shoot.start()
		$AudioStreamPlayer.play()
		
	move_and_slide()

func _on_shoot_timer_timeout() -> void:
	can_shoot = true
	
func destroy():
	animation_player.play("destroyed")
	print("damage")
	
func eliminated():
	if !self.is_queued_for_deletion():
		get_parent().remove_child(self)
		queue_free()
