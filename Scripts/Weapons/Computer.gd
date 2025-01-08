extends Node2D

@export var speed : float = 200.0

@onready var player: Node2D = $"../Player"
var computer_container : Node2D

func _ready() -> void:
	computer_container = get_tree().get_first_node_in_group("ComputerContainer")

func _process(delta: float) -> void:
	global_position = global_position.move_toward(computer_container.global_position, speed*delta)

#The computer will follow the player
func attach_to_player():
	return
	global_position = player.global_position
	reparent(player)

#It'll stop follow the player
#Called by Spawners and Global
func disconnect_from_player(reset_position = false):
	return
	reparent(owner)
	if reset_position:
		global_position = Vector2.ZERO
