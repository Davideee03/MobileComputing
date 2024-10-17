extends Node2D

@export_category("Movement")
@export var speed : float = 500.0
var last_direction : Vector2
var direction : Vector2

var first_position : Vector2
var is_dragging : bool = false

func _ready():
	first_position = global_position

func _input(event):
	if Input.is_action_just_pressed("esc"):
		get_tree().quit()
	
	if event is InputEventScreenTouch:
		is_dragging = false
		if event.is_pressed():
			first_position = (event.position - (get_viewport().size*0.5))
		else:
			first_position = global_position
	elif event is InputEventScreenDrag:
		var target : Vector2 = (event.position - (get_viewport().size*0.5))
		direction = first_position.direction_to(target).normalized()
		is_dragging = true
		

func _process(delta):
	if is_dragging:
		global_position += direction * speed * delta
