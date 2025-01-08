extends Explosives

var damage : float = 5000
var time : float = 2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	damage_area()

#Deals damage to enemies within the DamageArea
func damage_area() -> void:
	await get_tree().create_timer(time).timeout
	var DamageArea = get_child(0)
	var overlapping_areas = DamageArea.get_overlapping_areas()
	for area in overlapping_areas:
		area.take_damage(damage)
	queue_free()
	print("Grenade exploded")
