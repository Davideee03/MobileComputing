extends Label

# this script is used in the shop for showing the level of the weapons.
#Reference to the player weapon
var weapon: Node2D
@onready var level_label: Label = self 
#Class whose it's related
@export var new_weapon : Weapon
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	weapon = get_tree().get_first_node_in_group("PlayerWeapon")
	update_level_label()

func update_level_label() -> void:
	var weapon_data = WeaponSave.weapon_stats
	if weapon_data.has(new_weapon.name):
		var current_weapon = weapon_data[new_weapon.name]
		level_label.text = new_weapon.name + " lv. " + str(current_weapon["level"])
	else:
		level_label.text = new_weapon.name + " lv. " + str(new_weapon.level)
	#var weapon_data = WeaponSave.load_weapon_data() 
	# Cerco l'arma con lo stesso nome, se esiste prendo le statistiche da lui
	#if weapon_data.has(new_weapon.name):
	#	var saved_weapon = weapon_data[new_weapon.name]
		#level_label.text = new_weapon.name + " lv. " + str(saved_weapon["level"])
	#else:
	#	level_label.text = new_weapon.name + " lv. " + str(new_weapon.level)
		
		
func _on_upgrade_gun_button_down() -> void:
	if weapon.pri() < Stats.current_coreNormal + weapon.pri():
		update_level_label()


func _on_reset_button_weapons_button_down() -> void:
	level_label.text = new_weapon.name + " lv. " + str(new_weapon.level)
