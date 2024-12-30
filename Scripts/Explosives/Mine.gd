extends Explosives

var damage : float = 5000
var time : float = 0.1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#Check if enemies have entered the area
func _on_detector_area_entered(area):
	await get_tree().create_timer(time).timeout
	damage_area()

#Deals damage to enemies within the DamageArea
func damage_area() -> void:
	var DamageArea = get_child(1)
	var overlapping_areas = DamageArea.get_overlapping_areas()
	print(overlapping_areas)
	for area in overlapping_areas:
		area.take_damage(damage)
		print("Danno")
	queue_free()
