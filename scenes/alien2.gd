extends Node2D

var Missile = preload("res://scenes/missile.tscn")

@onready var time_moving = $MovingTimer
@onready var animation_alien = $AnimationAlien
@onready var spawn_point = $spawnPoint

const SPEED = 300.0

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
	animation_alien.connect("animation_finished", Callable(self, "_on_explosion_finished"), CONNECT_ONE_SHOT)

func _on_explosion_finished(anim_name):
	if anim_name == "destroy":
		$AudioStreamPlayer.play()
		elimination()
	
func elimination():
	emit_signal("dead_alien")
	queue_free()

func shoot():
	var missile = Missile.instantiate()
	missile.global_position = spawn_point.global_position
	get_parent().add_child(missile)
