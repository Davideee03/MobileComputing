extends Button

@onready var weapon_save = get_node("/root/WeaponSave")

func _on_button_down() -> void:
	weapon_save.reset_weapons()
	print("Armi resettate")
