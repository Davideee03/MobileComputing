class_name ExplosivesShopButton
extends Control

@export var mine: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_mine_button_down() -> void:
	var explosive = mine.instantiate()
	get_tree().root.add_child(explosive)
	explosive.global_position = Vector2(200,200)
