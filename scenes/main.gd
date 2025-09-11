extends Node

var points = 0
@onready var label_points = $VBoxContainer/Labelpoints

func plus_alien_points():
	points += 100
	label_points.text = str(points)
