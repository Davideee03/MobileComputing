extends Control

func _ready() -> void:
	for child in get_children():
		await get_tree().create_timer(0.12).timeout
		child.play()

func update_health(current_health : int):
	for i in get_child_count():
		var heart = get_child(i)
		if i<current_health:
			heart.visible = true
		else:
			heart.visible = false
