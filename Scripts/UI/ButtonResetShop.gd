extends Button
@onready var weapon_save = get_node("/root/WeaponSave")
func _on_button_down() -> void:
	reset_weapon_save()

# Path del file di salvataggio
var weapon_save_path = "user://weapons.dat"

# Funzione per resettare il file di salvataggio
func reset_weapon_save() -> void:
	weapon_save.reset_weapons()
	print("Shop Resettato")
