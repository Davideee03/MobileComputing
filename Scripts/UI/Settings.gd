extends Label

@onready var h_slider: HSlider = $HSlider

func _ready() -> void:
	AudioServer.set_bus_volume_db(0, h_slider.value)
	AudioServer.set_bus_volume_db(1, h_slider.value)
	AudioServer.set_bus_volume_db(2, h_slider.value)
	AudioServer.set_bus_volume_db(3, h_slider.value)
	AudioServer.set_bus_volume_db(4, h_slider.value)

func _on_h_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(0, value)
	AudioServer.set_bus_volume_db(1, value)
	AudioServer.set_bus_volume_db(2, value)
	AudioServer.set_bus_volume_db(3, value)
	AudioServer.set_bus_volume_db(4, value)
