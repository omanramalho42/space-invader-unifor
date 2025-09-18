extends Node

var Alien = preload("res://scenes/alien.tscn")

@onready var timer_shoot = $ShootTimer

var aliens_list = []

func _ready() -> void:
	for j in range(4):
		aliens_list.append([])
		for i in range(8):
			var alien = Alien.instantiate()
			alien.global_position = Vector2(55 + 20 * i, 40 + 20 * j)
			self.add_child(alien)
			aliens_list[j].append(alien)
			alien.connect("dead_alien", Callable(self, "eliminate_alien"))
			alien.connect("dead_alien", Callable(get_parent(), "plus_alien_points"))
			
func eliminate_alien(a):
	for fila in aliens_list:
		for i in range(len(fila) - 1):
			if a == fila[i]:
				fila.remove_at(i)


func _on_down_timer_timeout() -> void:
	print("descendo")
	for fila in aliens_list:
		for a in fila:
			if	is_instance_valid(a):
				a.position.y += 21


func _on_shoot_timer_timeout() -> void:
	var lifes_aliens_list = []
	for fila in aliens_list:
		for a in fila:
			if is_instance_valid(a) and !a.is_queued_for_deletion():
				lifes_aliens_list.append(a)

	#Vamos colocar para apenas
	#os aliens vivos e os primeiros da fila
	#poderem disparar
	if lifes_aliens_list:
		var indice = int(floor(randf_range(0, len(lifes_aliens_list) - 1)))
		lifes_aliens_list[indice].shoot()
		timer_shoot.wait_time = randf_range(2, 5)
