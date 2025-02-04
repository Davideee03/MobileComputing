extends ProgressBar

#Label reference
@onready var wave_label: Label = $WaveLabel

var max_enemies_for_this_wave : int

#Called by Spawners
func display_wave(enemies_defeated : int, max_enemies : int = max_value):
	#Set up condition
	#Called only once per wave
	if max_value<max_enemies_for_this_wave || !visible:
		max_value = max_enemies_for_this_wave
		wave_label.text = "Wave " + str(Stats.current_wave+1)
		visible = true
	#Udate the value
	value = enemies_defeated

func hyde():
	visible = false

func _on_enemy_spawners_wave_ended(player_won: Variant) -> void:
	hyde()

func _on_enemy_spawners_wave_started(max_enemies: Variant) -> void:
	max_enemies_for_this_wave = max_enemies
	display_wave(0, max_enemies_for_this_wave)

func _on_enemy_spawners_wave_updated(enemies_defeated: Variant) -> void:
	display_wave(enemies_defeated)
