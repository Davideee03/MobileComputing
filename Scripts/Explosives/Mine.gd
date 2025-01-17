extends Explosive

var time : float = 0.2

#Check if enemies have entered the area
func _on_detector_area_entered(_area):
	await get_tree().create_timer(time).timeout
	damage_enemies()
