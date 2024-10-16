extends BuildingHealth

var player = null
var player_near : bool = false

func _on_destroyed():
	get_tree().reload_current_scene()

func _process(_delta):
	if player==null: return
	global_position = player.global_position

func set_player(new_player):
	if !player_near: return
	if player==null:
		player = new_player
	else:
		player = null


func _on_player_detector_area_entered(_area):
	player_near = true
func _on_player_detector_area_exited(_area):
	player_near = false
