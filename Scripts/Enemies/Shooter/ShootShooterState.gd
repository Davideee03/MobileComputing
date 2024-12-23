class_name ShootShooterState

extends ShooterMovementState

@export var projectile : PackedScene
@export var reload_time : float = 0.6

var idle : bool = false
var can_shoot : bool = false
@onready var shooting_point: Node2D = %ShootingPoint
var bullet_container : Node

func enter() -> void:
	can_shoot = false
	idle = false
	await get_tree().create_timer(reload_time).timeout
	can_shoot = true

func update(delta):
	var direction : Vector2 = SHOOTER.global_position.direction_to(TARGET.global_position)
	SHOOTER.update_direction(direction)
	
	if can_shoot: shoot()
	if idle:
		transition.emit("IdleShooterState")

func shoot():
	if !bullet_container: bullet_container = get_node("/root/World/BulletContainer")
	
	var bullet = projectile.instantiate()
	bullet_container.add_child(bullet)
	
	var shooting_dir : Vector2 = SHOOTER.global_position.direction_to(PLAYER.global_position)
	bullet.set_up(shooting_point.global_position, shooting_dir, SHOOTER.damage)
	
	can_shoot = false
	reload()

func reload():
	await get_tree().create_timer(reload_time).timeout
	can_shoot = true

func _on_stop_shooting_area_exited(area: Area2D) -> void:
	idle = true
