extends Node2D

#Movement
@export var speed : float = 300.0
@export var run_speed : float = 550.0
@export var acelleration : float = 100.0
var actual_speed : float

@onready var animation_player: AnimationPlayer = $AnimationPlayer
var is_dragging : bool = false

#Player references
var player: Node2D

var too_distant : bool = false

var first_position : Vector2

func _init() -> void:
	actual_speed = speed

func _ready() -> void:
	first_position = global_position

func _process(delta: float) -> void:

	if !player: animation_player.play("Idle", -1, 0.8); return
	animation_player.play("Walk", -1, 2)
	global_position = global_position.move_toward(player.global_position, actual_speed*delta)

	
	if too_distant: 
		actual_speed = move_toward(actual_speed, run_speed, delta*acelleration)

func reset():
	global_position = first_position

func _on_player_detector_body_entered(_body: Node2D) -> void:
	player = null
	actual_speed = speed
	too_distant = false

func _on_player_detector_body_exited(body: Node2D) -> void:
	player = body

func _on_increase_speed_area_body_exited(_body: Node2D) -> void:
	too_distant = true
