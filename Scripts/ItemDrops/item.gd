extends Area2D
var item_type : int

var coreNormal = preload("res://Sprites/Items/GEM 2 - BLUE - 0008.png")
var coreRare = preload("res://Sprites/Items/GEM 2 - LIGHT GREEN - 0008.png")
var coreEpic = preload("res://Sprites/Items/GEM 2 - PURPLE - 0008.png")
var coreLegendary = preload("res://Sprites/Items/GEM 2 - GOLD - 0008.png")

var texturesArray = [coreNormal, coreRare, coreEpic, coreLegendary]
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Sprite2D.texture = texturesArray[item_type]


# whenever the player enter the drop item area, it adds to the stats and to other things
func _on_area_entered(area: Area2D) -> void:
	if item_type == 0:
		Stats.current_coreNormal += 1
		Stats.emit_stats()
	elif item_type == 1:
		Stats.current_coreRare += 1
		Stats.emit_stats()
	elif item_type == 2:
		Stats.current_coreEpic += 1
		Stats.emit_stats()
	else:
		Stats.current_coreLegendary += 1
		Stats.emit_stats()
		
	Global.remove_drops(self)
	queue_free()
