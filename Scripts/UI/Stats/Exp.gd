extends ProgressBar

@export var increase_max_value : int = 37

@onready var health_label: Label = $HealthLabel

func update_exp(exp : int):
	if max_value<Stats.current_max_exp:
		max_value = Stats.current_max_exp
	value = exp
	
	if value>=max_value:
		value -= max_value
		max_value+=increase_max_value
		Stats.current_max_exp = max_value
		Stats.current_exp = value
		Stats.current_lvl+=1
	
	health_label.text = "Level "+str(Stats.current_lvl)
