extends Label


# this script is used in the shop for showing the stats for each weapon
#Reference to the player weapon
var weapon: Node2D
@onready var level_label: Label = self 
#Class whose it's related
@export var new_weapon : Weapon
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	weapon = get_tree().get_first_node_in_group("PlayerWeapon")


func _on_upgrade_gun_button_down() -> void:
	if weapon.pri() < Stats.current_money:
		level_label.text = "Stats\n" + "Damage: " + str(weapon.getDamage()) + "\n" + "Reload time: " + str(weapon.getReload()) + "\n" + "Price: " + str(weapon.pri())  
	else:
		pass
