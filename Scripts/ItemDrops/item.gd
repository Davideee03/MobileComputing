extends Area2D

var item_type : int = 0

var coreNormal = preload("res://Sprites/Items/GEM 2 - BLUE - 0008.png")
var coreRare = preload("res://Sprites/Items/GEM 2 - LIGHT GREEN - 0008.png")
var coreEpic = preload("res://Sprites/Items/GEM 2 - PURPLE - 0008.png")
var coreLegendary = preload("res://Sprites/Items/GEM 2 - GOLD - 0008.png")

enum cores {coreNormal, coreRare, coreEpic, coreLegendary}

var texturesArray = [coreNormal, coreRare, coreEpic, coreLegendary]

var player

const speed : float = 550.0

@onready var sprite: Sprite2D = $Sprite2D
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _ready() -> void:
	#Choose a random rarity
	item_type = random_rarity()
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

#Used to collect an item when the player is very close
func item_collected():
	#Update the core stats
	Stats.add_core(cores.find_key(item_type))     #It passes the core name
	Global.remove_drops(self)
	
	#Player collect sound
	audio_stream_player.pitch_scale = randf_range(1.0, 1.05)
	audio_stream_player.play()
	
	#Destroy the item once the audio is finished
	await audio_stream_player.finished
	queue_free()

func random_rarity():
	return randi_range(0,cores.size()-1)

#Notify that the player can collect the item
func _on_collect_area_area_entered(_area: Area2D) -> void:
	item_collected()
