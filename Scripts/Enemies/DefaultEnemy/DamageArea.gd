extends Area2D

@export var hit_time : float = 0.2
var damage : int 

#Set the damage value
func _ready() -> void:
	damage = get_parent().damage

#Hit the player
func _on_area_entered(area: Area2D) -> void:
	area.take_damage(damage)
