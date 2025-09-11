extends Area2D

var speed = 200

func _process(delta: float) -> void:
	position.y += speed * delta

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("tank"):
		body.destroy()
		queue_free()
