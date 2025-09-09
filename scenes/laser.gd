extends Area2D

var velocity = 200

func _ready() -> void:
	pass # Replace with function body.
	
func _process(delta: float) -> void:
	position.y -= velocity * delta

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("aliens"):
		body.explosion()
		get_parent().remove_child(self)
		queue_free()
