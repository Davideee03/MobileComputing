extends Label

var current_money : int = 0

func _ready():
	Score.update_money.connect(update_money)

func update_money(money):
	current_money+=money
	
	text = "Money: " + str(current_money)
