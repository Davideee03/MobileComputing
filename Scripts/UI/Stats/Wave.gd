extends ProgressBar

#Label reference
@onready var wave_label: Label = $WaveLabel

#Called by Spawners
func display_wave(enemies_defeated : int, max_enemies : int = max_value):
	#Set up condition
	#Called only once per wave
	if max_value<max_enemies || !visible:
		max_value = max_enemies
		wave_label.text = "Wave " + str(Stats.current_wave)
		visible = true
	#Udate the value
	value = enemies_defeated

func hyde():
	visible = false

func _on_enemy_spawners_wave_ended(player_won: Variant) -> void:
	hyde()
