extends Control

@export var show_loading_screen : bool = true

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	if show_loading_screen:
		animation_player.play("Loading")
		return
	queue_free()

func _on_animation_player_animation_finished(_anim_name: StringName) -> void:
	queue_free()
