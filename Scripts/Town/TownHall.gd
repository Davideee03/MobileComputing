extends BuildingHealth


func _on_destroyed():
	#Since it's the town hall,
	#restart the level if it's detroyed
	get_tree().reload_current_scene()
