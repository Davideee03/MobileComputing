extends TabContainer


func _ready():
	var screen_size = get_viewport_rect().size
	custom_minimum_size = screen_size * 0.8  
