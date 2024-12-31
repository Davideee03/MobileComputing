class_name ExplosivesButton
extends Control

var game_started : bool = false

@export var mine: PackedScene
@export var grenade: PackedScene

var mine_count : float = 1
var grenade_count : float = 1

@onready var mine_button : Button = $Mine
@onready var grenade_button : Button = $Grenade

var player : CharacterBody2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_start_wave_button_button_down() -> void:
	game_started = true
	

#Creates the mine at the player's position
func _on_mine_button_down() -> void:
	if (mine_count > 0) and game_started:
		player = get_parent().get_parent().get_parent()
		await get_tree().create_timer(2).timeout
		var explosive = mine.instantiate()
		get_tree().root.add_child(explosive)
		explosive.global_position = player.global_position
		mine_count -= 1
		print("Mines available: "+ str(mine_count))
		mine_button.text = "Mine: " + str(mine_count)
	elif (mine_count == 0):
		print("No mines available")
	else:
		print("Game not started yet")

#Creates the Grenade at the player's position
func _on_grenade_button_down() -> void:
	if (grenade_count > 0) and game_started:
		player = get_parent().get_parent().get_parent()
		await get_tree().create_timer(2).timeout
		var explosive = grenade.instantiate()
		get_tree().root.add_child(explosive)
		explosive.global_position = player.global_position
		grenade_count -= 1
		print("Grenades available: "+ str(grenade_count))
		grenade_button.text = "Grenade: " + str(grenade_count)
	elif (mine_count == 0):
		print("No Grenades available")
	else:
		print("Game not started yet")
