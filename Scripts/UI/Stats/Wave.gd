extends ProgressBar

#Label reference
@onready var wave_label: Label = $WaveLabel

func display_wave(enemies_defeated : int, max_enemies : int = max_value):
	#Set up condition
	#Called only once per wave
	if max_value<max_enemies:
		max_value = max_enemies
		wave_label.text = "Wave " + str(Stats.current_wave)
		visible = true
	
	#Udate the value
	value = enemies_defeated
	
	#Hyde the bar at the end of the wave
	if value == max_value:
		visible = false
