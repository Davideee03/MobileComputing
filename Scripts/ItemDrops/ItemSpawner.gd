extends Node2D

@export var max_wait_time : float = 20.0
@export var min_wait_time : float = 10.0

const ITEM = preload("res://Scenes/ItemDrops/item.tscn")
@onready var items: Node = %Items

var parent

func _ready() -> void:
	parent = get_parent()

func spawn():
	await get_tree().create_timer(random_wait_time()).timeout
	
	if !parent.can_spawn: return
	
	var item = ITEM.instantiate()
	items.add_child(item)
	
	item.global_position = global_position
	
	spawn()

func random_wait_time():
	return randf_range(min_wait_time, max_wait_time)
