extends Bullet

#var max_damage : float = 15.0
var min_damage : float = 2.0
var max_distance : float = 1000.0

#Damage Calculated Based on Distance
func calculate_damage(distance: float) -> float:
	var clamped_distance = clamp(distance, 0, max_distance)
	var t = clamped_distance / max_distance
	return lerp(damage, min_damage, t)
