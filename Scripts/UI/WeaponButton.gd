class_name ShopButton
extends Button

#Reference to the player weapon
var weapon: Node2D

#Class whose it's related
@export var new_weapon : Weapon

func _ready() -> void:
	#Get the player weapon
	weapon = get_tree().get_first_node_in_group("PlayerWeapon")

#When pressed, change the player weapon parameters
func _on_button_down() -> void:
	weapon.load_weapon(new_weapon)
