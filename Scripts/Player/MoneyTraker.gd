extends Label

var current_money : int = 0

func _ready():
	#Connect to the global script Score
	Score.update_money.connect(update_money)

#Update money accordingly to Score
func update_money(money):
	current_money+=money
	
	text = "Money: " + str(current_money)
