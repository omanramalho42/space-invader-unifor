extends StaticBody2D

var golpes = 0

@onready var animation_player = $AnimationPlayer

func _ready():
	comprovate_damage()

func destroy():
	print("destruir block")
	golpes += 1
	comprovate_damage()
	
func comprovate_damage():
	if golpes == 0:
		animation_player.play("normal")
	elif golpes == 1:
		animation_player.play("danified")
	elif golpes == 2:
		queue_free()
