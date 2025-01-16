extends Area2D

var item_type : int = 0

var coreNormal = preload("res://Sprites/Items/Carbon.png")
var coreRare = preload("res://Sprites/Items/GEM 2 - LIGHT GREEN - 0008.png")
var coreEpic = preload("res://Sprites/Items/GEM 2 - PURPLE - 0008.png")
var coreLegendary = preload("res://Sprites/Items/GEM 2 - GOLD - 0008.png")

enum cores {coreNormal, coreRare, coreEpic, coreLegendary}

var texturesArray = [coreNormal, coreRare, coreEpic, coreLegendary]

var player
var can_collected : bool = false

const speed : float = 550.0

@onready var sprite: Sprite2D = $Sprite2D
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	#Choose a random rarity
	item_type = choose_rarity()
	#Change the sprite
	sprite.texture = texturesArray[item_type]

func _process(delta: float) -> void:
	#Move towards the player if he's close
	if !player: return
	global_position = global_position.move_toward(player.global_position, speed*delta)

#Whenever the player enter the drop item area, start following the player
func _on_area_entered(_area: Area2D) -> void:
	follow_player()

#Called also at the end of every wave by "Spawners"
func follow_player():
	#Get the player node
	player = get_tree().get_first_node_in_group("Player")
	if global_position.distance_to(player.global_position)>=750:
		destroy()

#Used to collect an item when the player is very close
func item_collected():
	#Update the core stats
	Stats.add_core(cores.find_key(item_type))     #It passes the core name
	
	#Player collect sound
	audio_stream_player.pitch_scale = randf_range(0.8, 1.1)
	audio_stream_player.play()
	
	#Make it invisible
	sprite.visible = false
	
	#Destroy the item once the audio is finished
	await audio_stream_player.finished
	destroy()

#With this method, it is possibile to choose a rarity for the item
#Rarity possibilities:
#- 1/2 --> Normal
#- 3/10 --> Rare
#- 2/30 --> Epic
#- 1/20 --> Legendary
func choose_rarity():
	#Choose a random number
	var rand : int = randi_range(5, 105)
	#print("Rand: " + str(rand))
	#Maximum decrease factor
	var i : int = 20
	#Initial probablility
	var prob : int = 50
	#Core counter
	var core : int = 0
	
	while i>=10:
		#Find the percentage
		var percentage : float = rand/prob
		#print("Percentage: " + str(percentage))
		if percentage>=1: 
			#print("Core: " + str(core))
			return core
		prob-=i
		#print("Next prob: " + str(prob))
		i-=5
		core+=1
	
	return cores.size()-1

func destroy():
	Global.remove_drops(self)
	queue_free()

#Notify that the player can collect the item
func _on_collect_area_area_entered(_area: Area2D) -> void:
	item_collected()

func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	destroy()

func _on_collect_after_wave_enabler_screen_entered() -> void:
	can_collected = true
func _on_collect_after_wave_enabler_screen_exited() -> void:
	can_collected = false
