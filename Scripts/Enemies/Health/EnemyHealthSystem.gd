class_name EnemyHealthSystem
extends Area2D

var health : int 

const ENEMY_HITTED = preload("res://Soundeffects/Enemy/EnemyHitted.wav")
const HIT_PARTICLE_SYSTEM = preload("res://Scenes/Enemies/HitParticleSystem.tscn")

func _ready() -> void:
	health = owner.health*pow(Stats.current_wave, 0.5)

func take_damage(damage : float):
	health-=damage
	if health<=0:
		owner.die() 
		return
	
	var particle_system : CPUParticles2D = HIT_PARTICLE_SYSTEM.instantiate()
	add_child(particle_system)
	particle_system.global_position = global_position
	particle_system.emitting = true
	
	UniversalAudioPlayer.play_hit()
