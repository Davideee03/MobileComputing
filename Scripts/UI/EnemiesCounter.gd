extends Label

@onready var enemy_spawners: Node2D = %EnemySpawners

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	text = "Wave: " + str(Stats.current_wave)
	text += "\n" + "Utilities: " + str(Utilities2.get_max_enemy_number())
	text += "\n" + "Max enemies: " + str(enemy_spawners.max_enemies)
	text += "\n" + "Enemies defeated: " + str(enemy_spawners.enemies_defeated)
	text += "\n" + "Wave Started: " + str(enemy_spawners.enemies_defeated)
