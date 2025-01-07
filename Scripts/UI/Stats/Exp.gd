extends ProgressBar

@export var increase_max_value : int = 50

@onready var health_label: Label = $HealthLabel

func update_exp(exp : int):
	print(exp)
	value = exp
	print(value)
	
	if value>=max_value:
		value -= max_value
		max_value+=increase_max_value
		Stats.current_exp = value
	
	health_label.text = str(value)+"/"+str(max_value)
