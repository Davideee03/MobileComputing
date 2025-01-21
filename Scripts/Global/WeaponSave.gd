extends Node
# Pathof the saving file
var weapon_save_path = "user://weapons.dat"

# Dictionary to store the weapons
var weapon_stats = {}
var loaded_weapons = {}


func _ready() -> void:
	loaded_weapons = load_weapon_data()
	print(loaded_weapons)

# Saving the weapon 
func save_weapon(weapon: Weapon) -> void:
	weapon_stats[weapon.name] = {
		"damage": weapon.damage,
		"reload_time": weapon.reload_time,
		"level": weapon.level,
		"price": weapon.price,
		# boolean for bought or not to fix the buy button bug
		"bought": weapon.bought
	}

	# Writing on the file 
	var save = FileAccess.open(weapon_save_path, FileAccess.WRITE)
	save.store_var(weapon_stats)
	save.close()
	
	print("Arma salvata: " + weapon.name)

#Loading weapons
func load_weapon_data() -> Dictionary:
	if FileAccess.file_exists(weapon_save_path):
		var save = FileAccess.open(weapon_save_path, FileAccess.READ)
		weapon_stats = save.get_var()
		save.close()
		print("Dati delle armi caricati!")
		#Dictionary of the loaded weapons
		var loaded_weapons = {}
		
		# loop to create the weapons in the game if we have them in the dictionary with upgraded stats
		for weapon_name in weapon_stats:
			var weapon = null
			match weapon_name:
				"Gun":
					weapon = Gun.new()
				"ShotGun":
					weapon = ShotGun.new()
				"AssaultRifle":
					weapon = AssaultRifle.new()
				"MachineGun":
					weapon = MachineGun.new()
			
			# if we have it we store it and get the stats
			if weapon != null:
				var data = weapon_stats[weapon_name]
				weapon.damage = data["damage"]
				weapon.reload_time = data["reload_time"]
				weapon.level = data["level"]
				weapon.price = data["price"]
				weapon.bought = data.get("bought", false)
				loaded_weapons[weapon_name] = weapon
				
		return loaded_weapons
	else:
		print("Nessun file di salvataggio.")
		return {}

#We load the stats to the weapon in game we have
func load_weapon(weapon: Weapon) -> void:
	if weapon_stats.has(weapon.name):
		var data = weapon_stats[weapon.name]
		weapon.damage = data["damage"]
		weapon.reload_time = data["reload_time"]
		weapon.level = data["level"]
		weapon.price = data["price"]
		weapon.bought = data.get("bought", false) 
		print("Loaded data to: " + weapon.name)
	else:
		print("Non ci stanno dati o robe di: " + weapon.name)
	
# function to reset to weapons stats called by the button of resetting inside the gun node	
func reset_weapons() -> void:
	print("Resetting...")
	weapon_stats.clear()  # Pulizia che forse richiede un pò di tempo 
	
	# Creating new weapons with default stats
	var gun = Gun.new()
	var shotgun = ShotGun.new()
	var assaultRifle = AssaultRifle.new()
	var machineGun = MachineGun.new()
	
	save_weapon(gun)
	save_weapon(shotgun)
	save_weapon(assaultRifle)
	save_weapon(machineGun)
	print("Reset completed. Armi Stats di default")
