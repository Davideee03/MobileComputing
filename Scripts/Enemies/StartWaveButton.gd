extends Button

@export var spawners : Node2D
@export var fuel_container : Area2D

@onready var buttons: Control = %Buttons

var is_near_to_fuel : bool = false

func _on_button_down():
	#Start wave only if the player is near
	#to the fuel container
	if !is_near_to_fuel: return
	spawners.start_wave()
	
	#Set fuel container position
	fuel_container.follow_player()
	
	#Disable Button
	disabled = true
	
	#Make the buttons invisible
	buttons.visible = false

func end_wave():
	#Enable button
	disabled = false
	fuel_container.stop_following_player()
	
	#Make the buttons visible
	buttons.visible = true


func _on_player_detector_area_entered(_area):
	is_near_to_fuel = true
func _on_player_detector_area_exited(_area):
	is_near_to_fuel = false
