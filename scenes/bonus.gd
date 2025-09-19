extends CharacterBody2D

signal bonus_eliminated
var velocidade = 50

func process(delta):
	position.x -= velocidade * delta

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "destroyed":
		emit_signal("bonus_eliminated")
		queue_free()

func explosion():
	$AnimationPlayer.play("destroyed")
