extends Control

#Ui references
@onready var buttons: Control = $Buttons
@onready var shop: Control = $Shop

#Stats
@onready var money: Label = %Money
@onready var waves: Label = %Waves
@onready var exp: Label = %Exp
@onready var health: Label = %Health
@onready var coreNormal: Label = %CoreNormal
@onready var coreRare: Label = %CoreRare
@onready var coreEpic: Label = %CoreEpic
@onready var coreLegendary: Label = %CoreLegendary

#Connect the signal in stats to update the currents statistics
func _ready() -> void:
	Stats.on_stats_changed.connect(display_new_stats)

#Hide or show the buttons when necessary
#Called in UI 
func change_buttons_visibility():
	for button in buttons.get_children():
		button.visible = !button.visible
		button.disabled = !button.disabled

#Display the stats
func display_new_stats(current_money, current_exp, current_wave, current_health, current_coreNormal,current_coreRare,current_coreEpic, current_coreLegendary ):
	money.text = "Money: " + str(current_money)
	waves.text = "Waves: " + str(current_wave)
	exp.text = "Exp: " + str(current_exp)
	health.text = "Health: " + str(current_health)
	coreNormal.text = "coreNormal: " + str(current_coreNormal)
	coreRare.text = "coreRare: " + str(current_coreRare)
	coreEpic.text = "coreEpic: " + str(current_coreEpic)
	coreLegendary.text = "coreLegendary: " + str(current_coreLegendary)

#Start a new wave
func _on_start_wave_button_button_down() -> void:
	change_buttons_visibility()

#Open the shop
func _on_shop_button_button_down() -> void:
	change_buttons_visibility()
	Global.shop_opened = true
	shop.visible = true
#Close the shop
func _on_shop_back_button_down() -> void:
	change_buttons_visibility()
	Global.shop_opened = false
	shop.visible = false
	
# developer button  for resetting the game to zero
func _on_reset_game_button_down() -> void:
	Stats.reset_to_zero()
	Stats.emit_stats()


func _on_cheats_button_down() -> void:
	Stats.current_money = 10000000000
	Stats.current_coreNormal = 1000000
	Stats.current_coreRare = 1000000
	Stats.current_coreEpic = 1000000
	Stats.current_coreLegendary = 1000000
	Stats.current_exp = 1000000
	Stats.emit_stats()
