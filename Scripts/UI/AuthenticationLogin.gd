extends Control

var COLLECTION_ID = "player_stats"

func _ready():
	Firebase.Auth.login_succeeded.connect(on_login_succeeded)
	Firebase.Auth.signup_succeeded.connect(on_signup_succeeded)
	Firebase.Auth.login_failed.connect(on_login_failed)
	Firebase.Auth.signup_failed.connect(on_signup_failed)
	
	if Firebase.Auth.check_auth_file():
		%LoginStatusLabel.text = "Logged in"
		load_data_from_cloud()

func _on_login_button_pressed():
	var email = %Email.text
	var password = %Password.text
	Firebase.Auth.login_with_email_and_password(email, password)
	%LoginStatusLabel.text = "Logging in"

func _on_signup_button_pressed():
	var email = %Email.text
	var password = %Password.text
	Firebase.Auth.signup_with_email_and_password(email, password)
	%LoginStatusLabel.text = "Signing up"

func on_login_succeeded(auth):
	print(auth)
	%LoginStatusLabel.text = "Login success!"
	Firebase.Auth.save_auth(auth)
	load_data_from_cloud()
	%SyncData.show()
	%Logout.show()

func on_signup_succeeded(auth):
	print(auth)
	%LoginStatusLabel.text = "Sign up success!"
	Firebase.Auth.save_auth(auth)
	load_data_from_cloud()

func on_login_failed(error_code, message):
	print(error_code, message)
	%LoginStatusLabel.text = "Login failed. Error: %s" % message

func on_signup_failed(error_code, message):
	print(error_code, message)
	%LoginStatusLabel.text = "Sign up failed. Error: %s" % message

func _on_logout_button_pressed():
	Firebase.Auth.logout()
	%LoginStatusLabel.text = "Logged Out!"

# Sincronizza i dati locali con Firestore
func _on_sync_data_button_pressed():
	save_data_to_cloud()

# Salvataggio dati su Firestore
func save_data_to_cloud():
	var auth = Firebase.Auth.auth
	
	if auth.localid:
		var collection: FirestoreCollection = Firebase.Firestore.collection(COLLECTION_ID)
		var data: Dictionary = {
			"player_stats": load_local_data()  # Carica i dati dai file locali
		}

		# Aggiorna o crea il documento Firestore
		var document = await collection.get_doc(auth.localid)
		if document:
			for key in data.keys():
				document.add_or_update_field(key, data[key])
			var task = await collection.update(document)
			if task:
				print("Cloud save: Success")
			else:
				print("Cloud save: Failed")
		else:
			document = await collection.add(auth.localid, data)
			if document:
				print("Cloud save: Document created successfully")
			else:
				print("Cloud save: Failed to create document")

# Carica i dati dal cloud al login
func load_data_from_cloud():
	var auth = Firebase.Auth.auth
	
	if auth.localid:
		var collection: FirestoreCollection = Firebase.Firestore.collection(COLLECTION_ID)
		var document = await collection.get_doc(auth.localid)
		
		if document:
			var cloud_data = document.get_value("player_stats")
			if cloud_data:
				save_local_data(cloud_data)  # Sovrascrivi i dati locali
				print("Cloud load: Data loaded")
			else:
				print("Cloud load: No data found")
		else:
			print("Cloud load: Failed to load document")

# Funzioni per caricare e salvare dati localmente
func load_local_data() -> Dictionary:
	# Leggi i dati da tutti i file locali e combinali in un unico Dictionary
	var data = {}
	
	# Player stats
	if FileAccess.file_exists("user://PlayerStats.dat"):
		var file = FileAccess.open("user://PlayerStats.dat", FileAccess.READ)
		data["player_stats"] = file.get_var()
		file.close()
	
	# Consumables
	if FileAccess.file_exists("user://consume.dat"):
		var file = FileAccess.open("user://consume.dat", FileAccess.READ)
		data["consume_stats"] = file.get_var()
		file.close()
	
	# Weapons
	if FileAccess.file_exists("user://weapons.dat"):
		var file = FileAccess.open("user://weapons.dat", FileAccess.READ)
		data["weapon_stats"] = file.get_var()
		file.close()
	
	return data

func save_local_data(data: Dictionary):
	# Scrivi i dati ricevuti dal cloud nei rispettivi file locali
	
	# Player stats
	if data.has("player_stats"):
		var file = FileAccess.open("user://PlayerStats.dat", FileAccess.WRITE)
		file.store_var(data["player_stats"])
		file.close()
	
	# Consumables
	if data.has("consume_stats"):
		var file = FileAccess.open("user://consume.dat", FileAccess.WRITE)
		file.store_var(data["consume_stats"])
		file.close()
	
	# Weapons
	if data.has("weapon_stats"):
		var file = FileAccess.open("user://weapons.dat", FileAccess.WRITE)
		file.store_var(data["weapon_stats"])
		file.close()
