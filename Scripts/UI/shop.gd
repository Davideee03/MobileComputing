extends TabContainer


func _ready():
	# for future reference we can also anchor the shop to the screen (this is harder I think)
	# getting the display size of the mobile
	var screen_size = get_viewport_rect().size
	# setting the minimum size of the shop to 80% of the screen
	# for future implementation we can also create a function and make some staples for like tablet or other idk
	custom_minimum_size = screen_size * 0.8  
