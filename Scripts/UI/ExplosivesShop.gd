extends ExplosivesButton


func _ready():
	pass

#Update purchased mine counter
func _on_mine_pressed() -> void:
	mine_count += 1
	mine_button.text = "Mine: " + str(mine_count)
	print("Mine Purchased")
	
