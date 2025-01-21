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
@onready var damage_animator: AnimationPlayer = %DamageAnimator
@onready var hit_particle_system: CPUParticles2D = $HitParticleSystem
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var player_ref = get_node("/root/World/Player")

func _ready():
	spawner_container = get_tree().get_first_node_in_group("SpawnerContainer")
	
	await get_tree().create_timer(0.2).timeout
	current_health = Stats.current_health

func restore_health():
	#Set up the health
	current_health = total_health
	update_global_health()

func take_damage(damage : int):
	#If he's invincible, do not take damage
	if !can_take_damage: return
	current_health-=damage
	
	if current_health < 2:
		use_health_potion()
		
	#Update the global health
	#It is needed to be displayed
	update_global_health()
	
	print("Current health: " + str(current_health))
	
	#If he's been hitted, activate invicibility
	can_take_damage = false
	invincibility()
	
	#Reload current scene if negative health
	#Momentaneo
	if current_health<=0:
		spawner_container.end_wave()
	else:
		#Play the animation (Black Color rect)
		damage_animator.play("TakeDamage")
		
		hit_particle_system.emitting = true
		audio_stream_player.play()

func invincibility():
	#Invicibility duration
	await get_tree().create_timer(invincibility_time).timeout
	can_take_damage = true
	
func use_health_potion():
	var consumables = SaveConsumables.consume_stats
	# it works player_ref.speed = 1000
	if consumables.has("Potion") and consumables["Potion"]["amount"] > 0:
		consumables["Potion"]["amount"] -= 1
		print("Pozione usata! Aumenterà i cuori tra 2 secondi...")
		await get_tree().create_timer(time).timeout
		if current_health<2:
			_add_health_after_potion()

func _add_health_after_potion():
	current_health += 1
	# here I need to put the animation to give it back the hearth
	damage_animator.play("TakeDamage")
	if current_health > total_health:
		current_health = total_health 
	print(current_health)
	update_global_health()

func update_global_health():
	#Update the global health
	#It is needed to be displayed
	Stats.update_player_health(current_health)
