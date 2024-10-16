extends ProgressBar

var max_exp : float = 48.0
var current_exp : float

@onready var level_traker = $LevelTraker
var current_level : int = 0

func _ready():
	Score.update_exp.connect(update_exp)
	
	current_exp = max_exp
	max_value = max_exp
	
	new_level()

func update_exp(exp : float):
	current_exp += exp
	value = current_exp
	
	if current_exp>=max_exp:
		new_level()

func new_level():
	current_exp = 0
	value = 0
	
	current_level+=1
	level_traker.text = "Level: " + str(current_level)
