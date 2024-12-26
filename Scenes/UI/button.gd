extends Button

@onready var button = $Button
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_button_down() -> void:
	if Stats.current_money < 10:
		print("non hai abbastanza soldi")
	else:
		Stats.current_money = Stats.current_money - 10
		Stats.emit_stats()
		print("Buon acquisto")
