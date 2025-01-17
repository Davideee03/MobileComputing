extends Sprite2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func play():
	animation_player.play("HeartBeat")
