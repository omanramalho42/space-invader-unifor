extends Node

var Block = preload("res://scenes/block.tscn")

func _ready():
	var block = Block.instantiate()
	var screen_height = 224
	var screen_width = 256
	
	var n_blocks = screen_height/3
	
	for i in range(n_blocks):
		block = Block.instantiate()
		block.global_position = Vector2(2+i*4, screen_width+1)
		add_child(block)
