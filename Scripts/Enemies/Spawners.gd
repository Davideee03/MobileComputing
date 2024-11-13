extends Node2D

@export var max_enemies : int = 10
var current_enemies : int = 0
var enemies_defeated : int = 0

##UI##
@onready var ui: Control = %UI

func _process(delta: float) -> void:
	rotation += delta

func new_wave() -> void:
	set_up()
	
	for spawner in get_children():
		spawner.spawn()

func update_wave(enemy_value : int):
	if enemy_value>0: current_enemies+=enemy_value
	else: enemies_defeated-=enemy_value
	
	if enemies_defeated==max_enemies:
		player_won()

func player_won() -> void: 
	print("Player won!")
	ui.change_buttons_visibility()

func wave_ended():
	return max_enemies == current_enemies

func _on_start_wave_button_down() -> void:
	new_wave()

func set_up():
	current_enemies = 0
	enemies_defeated = 0
