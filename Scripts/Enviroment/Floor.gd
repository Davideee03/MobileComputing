extends Sprite2D

#Reference to the floor
const FLOOR = preload("res://Scenes/Enviroment/Floor.tscn")

#Reference to the parent
#It stores the floors position
@onready var floor: Node = $".."

#Add to the parent it's position
func _ready() -> void:
	floor.add(global_position)

func spawn():
	#It's the y position multiplier
	var y : int = -1
	#It's the x position multiplier
	var x : int = -1
	#A counter
	var j : int = 0
	
	while y<2:
		#If there's no floor in this position, spawn 
		if !floor.has(global_position+Vector2(x*texture.get_width(), y*texture.get_height())):
			var next_floor = FLOOR.instantiate()
			get_parent().call_deferred("add_child", next_floor)
			next_floor.global_position = global_position+Vector2(x*texture.get_width(), y*texture.get_height())
		if !floor.has(global_position+Vector2(0, texture.get_height())):
			var next_floor = FLOOR.instantiate()
			get_parent().call_deferred("add_child", next_floor)
			next_floor.global_position = global_position+Vector2(0, texture.get_height())
		if !floor.has(global_position+Vector2(0, -texture.get_height())):
			var next_floor = FLOOR.instantiate()
			get_parent().call_deferred("add_child", next_floor)
			next_floor.global_position = global_position+Vector2(0, -texture.get_height())
		
		#Increase the counter and the multipliers
		if j<1:
			j+=1
		else:
			j = 0
			y+=1
		x*=-1

#Remove the node from the tree and from the floor_container
func delete():
	floor.delete(global_position)
	queue_free()

#Spawn new floors when the player enters in the floor area
func _on_player_detector_body_entered(body: Node2D) -> void:
	spawn()

#Remove the floor when it's not vible
func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	delete()
