extends Button

@onready var building_name = $BuildingName

func _ready():
	building_name.visible = false

func _on_button_down():
	building_name.visible = true
	building_name.text = owner.name
