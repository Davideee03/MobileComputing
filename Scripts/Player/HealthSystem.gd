extends Area2D

@export_category("Health")
@export var total_health : int = 5
var current_health : int
@export var can_take_damage : bool = true
var time = 5

@export_category("Invincibility")
@export var invincibility_time : float = 1.0

var spawner_container 

#Hit effects
@onready var damage_animator: AnimationPlayer
@onready var hit_particle_system: CPUParticles2D = $HitParticleSystem
@onready var dead_particle_system: CPUParticles2D = $DeadParticleSystem
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _ready():
	Stats.reset.connect(restore_health)
	
	spawner_container = get_tree().get_first_node_in_group("SpawnerContainer")
	
	damage_animator = get_node("/root/World/Player/UI/UI/DamageUI/DamageAnimator")
	
	await get_tree().create_timer(0.2).timeout
	current_health = Stats.current_health

func restore_health():
	#Set up the health
	current_health = total_health
	update_global_health()
	
	damage_animator.play_backwards("Death")
	dead_particle_system.emitting = false
	
	can_take_damage = true

func take_damage(damage : int):
	#If he's invincible, do not take damage
	if !can_take_damage: return
	current_health-=damage
	
	can_take_damage = false
	
	#Update the global health
	#It is needed to be displayed
	update_global_health()
	
	#Reload current scene if negative health
	#Momentaneo
	if current_health<=0:
		dead_particle_system.emitting = true
		damage_animator.play("Death")
		audio_stream_player.play_death()
		
		await damage_animator.animation_finished
		
		restore_health()
		spawner_container.end_wave()
	else:
		print("Current health: " + str(current_health))
		
		#If he's been hitted, activate invicibility
		invincibility()
		
		#Play the animation (Black Color rect)
		damage_animator.play("TakeDamage")
		
		hit_particle_system.emitting = true
		audio_stream_player.play_hit()

func invincibility():
	#Invicibility duration
	await get_tree().create_timer(invincibility_time).timeout
	can_take_damage = true

func update_global_health():
	#Update the global health
	#It is needed to be displayed
	Stats.update_player_health(current_health)
