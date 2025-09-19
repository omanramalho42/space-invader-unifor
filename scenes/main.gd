extends Node

var points = 0
@onready var label_points = $VBoxContainer/Labelpoints

func plus_aliens_points(_a):
	print("points")
	points += 100
	label_points.text = str(points)
	
func plus_bonus():
	points += 500
	label_points.text = str(points)
