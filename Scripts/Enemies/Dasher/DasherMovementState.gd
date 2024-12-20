class_name DasherMovementState

extends State

var DASHER : Dasher
var TARGET : Node2D
var PLAYER : CharacterBody2D
var ANIMATOR : AnimationPlayer

func _ready() -> void:
	await owner.ready
	DASHER = owner as Dasher
	TARGET = DASHER.target
	PLAYER = DASHER.player
	ANIMATOR = DASHER.animation_player
