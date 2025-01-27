extends Explosive

var time : float = 0.75

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(time).timeout
	damage_enemies()
