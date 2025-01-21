extends Control

@export var mine : PackedScene
@export var granade : PackedScene

#Explosives parent
var explosive_container: Node

func _ready() -> void:
	explosive_container = get_tree().get_first_node_in_group("ExplosiveContainer")

func _on_mine_button_down() -> void:
	if SaveConsumables.consume_stats["Mine"]["amount"] >0:
		spawn_explosive(mine)

func _on_granate_button_down() -> void:
	if SaveConsumables.consume_stats["Grenade"]["amount"] >0:
		spawn_explosive(granade)

func spawn_explosive(bomb : PackedScene):
	#Instantiate the explosive
	var explosive = bomb.instantiate()
	explosive_container.add_child(explosive)
	
	#Set the position
	explosive.global_position = explosive_container.global_position

func change_visibility():
	visible = !visible
