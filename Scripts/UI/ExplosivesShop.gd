extends ScrollContainer

var mine_count : float = 0


func _ready():
	pass


func _on_mine_pressed() -> void:
	mine_count += 1
