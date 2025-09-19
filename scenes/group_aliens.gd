extends Node

var Alien1 = preload("res://scenes/alien.tscn")
var Alien2 = preload("res://scenes/alien2.tscn")
var Alien3 = preload("res://scenes/alien3.tscn")

var Bonus = preload("res://scenes/bonus.tscn")

@onready var timer_shoot = $ShootTimer

var aliens_list = []

func _ready() -> void:
	$BonusTimer.wait_time = randf_range(3.0, 20.0)
	$BonusTimer.start()
	
	# Lista com os tipos de alien
	var alien_types = [Alien1, Alien2, Alien3]
	
	for j in range(4):
		aliens_list.append([])
		for i in range(8):
			# Escolhe aleatoriamente um tipo de alien
			var alien_scene = alien_types[randi() % alien_types.size()]
			var alien = alien_scene.instantiate()

			alien.global_position = Vector2(35 + 20 * i, 40 + 20 * j)
			self.add_child(alien)
			aliens_list[j].append(alien)

			alien.connect("dead_alien", Callable(self, "eliminate_alien"))
			alien.connect("dead_alien", Callable(get_parent(), "plus_aliens_points"))
			
func eliminate_alien(a):
	for fila in aliens_list:
		if a in fila:
			fila.erase(a)

func _on_down_timer_timeout() -> void:
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
		var indice = randi_range(0, lifes_aliens_list.size() - 1)
		lifes_aliens_list[indice].shoot()
		timer_shoot.wait_time = randf_range(2, 5)


func _on_bonus_timer_timeout() -> void:
	var bonus = Bonus.instantiate()
	self.add_child(bonus)
	bonus.connect("bonus_eliminated", Callable(get_parent(), "plus_points"))

	# Define novo tempo aleatório para o próximo bônus
	$BonusTimer.wait_time = randf_range(3.0, 20.0)
	$BonusTimer.start()
