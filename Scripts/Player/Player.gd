extends CharacterBody2D

@export_category("Movement")
@export var speed : float = 500.0
var last_direction : Vector2
var direction : Vector2

var first_position : Vector2
var is_dragging : bool = false

@onready var hitbox: Area2D = %Hitbox

func _ready():
	first_position = global_position

func _input(event):
	#Quit if esc is pressed
	#Just for computer development
	if Input.is_action_just_pressed("esc"):
		get_tree().quit()
	
	#If the sceen is touched
	#Select the current player position
	if event is InputEventScreenTouch:
		is_dragging = false
		if event.is_pressed():
			first_position = (event.position - (get_viewport().size*0.5))
		else:
			first_position = global_position
	#If ScreenDrag get the finger direction 
	elif event is InputEventScreenDrag:
		var target : Vector2 = (event.position - (get_viewport().size*0.5))
		direction = first_position.direction_to(target).normalized()
		is_dragging = true
		

func _process(delta):
	if is_dragging && !Global.shop_opened:
		#global_position += direction * speed * delta
		velocity = direction*speed
		move_and_slide()

#Reset the position and health if dead
#Called by Global
func reset():
	global_position = Vector2.ZERO
	hitbox.restore_health()
