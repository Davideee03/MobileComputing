extends Label

var weapon: Node2D
@onready var level_label: Label = self 
@export var new_weapon : Weapon

func _ready() -> void:
	weapon = get_tree().get_first_node_in_group("PlayerWeapon")
	update_stat_label()

func update_stat_label() -> void:
	var weapon_data = WeaponSave.load_weapon_data()
	
	if weapon_data.has(new_weapon.name):
		var saved_weapon = weapon_data[new_weapon.name]
		level_label.text = "Stats\n" + "Damage: " + str(saved_weapon["damage"]) + "\nReload time: " + str(saved_weapon["reload_time"]) + "\nPrice: " + str(saved_weapon["price"])
	else:
		level_label.text = "Stats\n" + "Damage: " + str(new_weapon.damage) + "\nReload time: " + str(new_weapon.reload_time) + "\nPrice: " + str(new_weapon.price)

func _on_upgrade_gun_button_down() -> void:
	if weapon.pri() < Stats.current_money:
		update_stat_label()


func _on_reset_button_weapons_button_down() -> void:
	level_label.text = "Stats\n" + "Damage: " + str(new_weapon.damage) + "\nReload time: " + str(new_weapon.reload_time) + "\nPrice: " + str(new_weapon.price)
