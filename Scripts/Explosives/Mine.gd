extends Explosives

var damage : float = 5.0
var time : float = 0.1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Check if enemies have entered the area
func _on_detector_area_entered(area):
	area.take_damage(damage)
	print("Danno")
	queue_free()

func _on_button_down() -> void:
	var explosive = mine.instantiate()
	add_child(explosive)
	explosive.global_position = position
