class_name ShooterMovementState

extends State

var SHOOTER : Shooter
var TARGET : Node2D
var PLAYER : CharacterBody2D
var ANIMATOR : AnimationPlayer

func _ready() -> void:
	await owner.ready
	SHOOTER = owner as Shooter
	TARGET = SHOOTER.target
	PLAYER = SHOOTER.player
	ANIMATOR = SHOOTER.animation_player
