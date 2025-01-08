extends ProgressBar

@onready var health_label: Label = $HealthLabel

func update_health(current_health : int):
	value = current_health
	health_label.text = "Health: " + str(value)+"/"+str(max_value)
