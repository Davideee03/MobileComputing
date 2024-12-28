class_name Explosives
extends Node

var mine : PackedScene = preload("res://Scenes/Explosives/Mine.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var explosive = mine.instantiate()
	add_child(explosive)
	explosive.global_position = get_parent().global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
