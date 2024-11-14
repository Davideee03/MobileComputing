extends Node2D

var enemies : Array[Node2D]

#Take trace of the closer enemies
func _on_emey_detector_area_entered(area):
	enemies.append(area)
func _on_emey_detector_area_exited(area):
	enemies.erase(area)
