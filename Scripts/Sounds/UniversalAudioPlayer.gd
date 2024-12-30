extends AudioStreamPlayer

@export var default_enemy_sound : Array[AudioStreamWAV]

func play_expolosion() -> void:
	stream = default_enemy_sound.pick_random()
	pitch_scale = randf_range(0.95,1.05)
	play()
