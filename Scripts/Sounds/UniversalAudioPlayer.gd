extends AudioStreamPlayer

@export var enemy_explosion : AudioStreamWAV
@export var enemy_hit : AudioStreamWAV

#Called by "Enemy"
func play_expolosion() -> void:
	stream = enemy_explosion
	play()

func play_hit() -> void:
	stream = enemy_hit
	play()

func play_default_pitch(audio : AudioStreamWAV):
	stream = audio
	pitch_scale = 1.0
	play()
