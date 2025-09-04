extends Node

var Alien = preload("res://scenes/alien.tscn")

# Called when the node enters the scene tree for the first time.
var aliens_list = []

func _ready() -> void:
	for j in range(4):
		aliens_list.append([])
		for i in range(8):
			var alien = Alien.instantiate()
			alien.global_position = Vector2(20+20*i, 40+20*j)
			self.add_child(alien)
			aliens_list[j].append(alien)
			#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
