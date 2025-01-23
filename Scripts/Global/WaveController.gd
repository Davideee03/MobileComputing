extends Node

var enemies : Array[PackedScene] = [
	preload("res://Scenes/Enemies/DefaultEnemy/EnemyDefault.tscn"),
	preload("res://Scenes/Enemies/Dasher/Dasher.tscn"),
	preload("res://Scenes/Enemies/Giant/Giant.tscn"),
	preload("res://Scenes/Enemies/Shooter/Shooter.tscn")
]

var current_enemies : Array[PackedScene]

func set_enemies():
	var wave : int = Stats.current_wave
	var wave_to_enemy : int = int(wave/5)
	if wave_to_enemy+1>enemies.size(): return enemies
	for i in wave_to_enemy+1:
		if !current_enemies.has(enemies[wave_to_enemy]):
			current_enemies.append(enemies[i])
	return current_enemies
