class_name ExplosivesButton
extends Control

@export var mine: PackedScene
var mine_count : float = 0
@onready var mine_button : Button = $Mine
var player : CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

#Creates the mine at the player's position
func _on_mine_button_down() -> void:
	if mine_count > 0:
		player = get_parent().get_parent().get_parent()
		await get_tree().create_timer(2).timeout
		var explosive = mine.instantiate()
		get_tree().root.add_child(explosive)
		explosive.global_position = player.global_position
		mine_count -= 1
		mine_button.text = "Mine: " + str(mine_count)
	else:
		print ("No mines available")
	
	
