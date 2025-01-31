extends Control

#Ui references
@onready var buttons: Control = $Buttons
@onready var shop: Control = $Shop
@onready var explosives: Control = $Explosives
@onready var auth: Control = $Auth

#Stats
#@onready var money: Label = %Money
#@onready var waves: Label = %Waves
@onready var exp: ProgressBar = %Exp
@onready var health: Control = %Health
@onready var coreNormal: Label = %CoreNormal
@onready var coreRare: Label = %CoreRare
@onready var coreEpic: Label = %CoreEpic
@onready var coreLegendary: Label = %CoreLegendary
@onready var consumables: Control = $Consumables

#Connect the signal in stats to update the currents statistics
func _ready() -> void:
	#Stats.on_stats_changed.connect(display_new_stats)
	Stats.exp_changed.connect(display_exp)
	Stats.health_changed.connect(display_health)
	Stats.cores_changed.connect(display_cores)

#Hide or show the buttons when necessary
#Called in UI and Spawners
func change_buttons_visibility():
	#explosives.change_visibility()
	for button in buttons.get_children():
		button.visible = !button.visible
		button.disabled = !button.disabled

func display_exp(current_exp):
	exp.update_exp(current_exp)
func display_health(current_health):
	health.update_health(current_health)
func display_cores(current_coreNormal,current_coreRare,current_coreEpic, current_coreLegendary):
	coreNormal.text = ": " + str(current_coreNormal)
	coreRare.text = ": " + str(current_coreRare)
	coreEpic.text = ": " + str(current_coreEpic)
	coreLegendary.text = ": " + str(current_coreLegendary)

#Display the stats
#func display_new_stats(current_money, current_exp, current_wave, current_health, current_coreNormal,current_coreRare,current_coreEpic, current_coreLegendary ):
	##money.text = "Money: " + str(current_money)
	#exp.update_exp(current_exp)
	##health.update_health(current_health)
	#coreNormal.text = ": " + str(current_coreNormal)
	#coreRare.text = ": " + str(current_coreRare)
	#coreEpic.text = ": " + str(current_coreEpic)
	#coreLegendary.text = ": " + str(current_coreLegendary)

#Start a new wave
func _on_start_wave_button_button_down() -> void:
	change_buttons_visibility()

#Open the shop
func _on_shop_button_button_down() -> void:
	change_buttons_visibility()
	health.visible = false
	Global.can_move = false
	shop.visible = true

#Close the shop
func _on_shop_back_button_down() -> void:
	change_buttons_visibility()
	health.visible = true
	Global.can_move = true
	shop.visible = false

#Developer button  for resetting the game to zero
func _on_reset_game_button_down() -> void:
	Stats.reset_to_zero()

#Adding almost infinite resources for the player 
func _on_cheats_button_down() -> void:
	#Stats.current_money = 10000000000
	Stats.current_coreNormal = 1000000
	Stats.current_coreRare = 1000000
	Stats.current_coreEpic = 1000000
	Stats.current_coreLegendary = 1000000
	Stats.current_exp = 1000000
	Stats.cores_changed.emit()


func _on_enemy_spawners_wave_ended(player_won: Variant) -> void:
	change_buttons_visibility()


func _on_auth_button_button_down() -> void:
	change_buttons_visibility()
	health.visible = false
	auth.visible = true


func _on_auth_back_button_down() -> void:
	change_buttons_visibility()
	health.visible = true
	auth.visible = false
