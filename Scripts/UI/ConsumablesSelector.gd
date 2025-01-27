extends Control

@export var wait_time : float = 2.0

@onready var enemy_spawners: Node2D = %EnemySpawners
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var explosive_container : Node2D

@onready var amount_mines: Label = %AmountMines
@onready var amount_grenades: Label = %AmountGrenades

var labels : Array

func _ready() -> void:
	explosive_container = get_tree().get_first_node_in_group("ExplosiveContainer")
	
	#Bad code
	labels.append(amount_grenades)
	labels.append(amount_mines)

func _on_granade_button_down() -> void:
	if SaveConsumables.consume_stats["Grenade"]["amount"] > 0:
		SaveConsumables.consume_stats["Grenade"]["amount"]-=1
		explosive_container.start_spawning("grenade")
		disable_choice()
		#explosive_container.select_explosive("granade")

func _on_mines_button_down() -> void:
	if SaveConsumables.consume_stats["Mine"]["amount"] > 0:
		SaveConsumables.consume_stats["Mine"]["amount"]-=1
		explosive_container.start_spawning("mine")
		disable_choice()
		#explosive_container.select_explosive("mine")

func _on_start_wave_button_button_down() -> void:
	enable_choice()

func enable_choice():
	var has_consumables : bool = false
	for consumable in SaveConsumables.consume_stats:
		if SaveConsumables.consume_stats[consumable]["amount"] > 0:
			has_consumables = true
			get_node("BackGround/"+consumable).disabled = false
		else:
			get_node("BackGround/"+consumable).disabled = true
	
	if has_consumables:
		for label in labels:
			label.update()
		
		visible = true
		animation_player.play("WaitTime", -1, 1/wait_time)
		return
	
	enemy_spawners.new_wave()
	visible = false

func disable_choice():
	visible = false
	enemy_spawners.new_wave()

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	if visible:
		disable_choice()

func _on_exit_button_down() -> void:
	disable_choice()
