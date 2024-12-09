extends Area2D

var item_type : int = 0

var coreNormal = preload("res://Sprites/Items/GEM 2 - BLUE - 0008.png")
var coreRare = preload("res://Sprites/Items/GEM 2 - LIGHT GREEN - 0008.png")
var coreEpic = preload("res://Sprites/Items/GEM 2 - PURPLE - 0008.png")
var coreLegendary = preload("res://Sprites/Items/GEM 2 - GOLD - 0008.png")

enum cores {coreNormal, coreRare, coreEpic, coreLegendary}

var texturesArray = [coreNormal, coreRare, coreEpic, coreLegendary]

@onready var sprite: Sprite2D = $Sprite2D

func _ready() -> void:
	#Choose a random rarity
	item_type = random_rarity()
	#Change the sprite
	sprite.texture = texturesArray[item_type]

#Whenever the player enter the drop item area, it adds to the stats and to other things
func _on_area_entered(area: Area2D) -> void:
	item_collected()

#Used to collect an item
#Called also at the end of every wave by "Spawners"
func item_collected():
	#Update the core stats
	Stats.add_core(cores.find_key(item_type))     #It passes the core name
	Global.remove_drops(self)
	queue_free()

func random_rarity():
	return randi_range(0,cores.size()-1)
