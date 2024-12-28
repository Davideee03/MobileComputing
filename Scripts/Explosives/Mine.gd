extends Explosives

var damage : float = 5.0
var time : float = 2.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func _on_detector_area_entered(area: Area2D) -> void:
	queue_free()
