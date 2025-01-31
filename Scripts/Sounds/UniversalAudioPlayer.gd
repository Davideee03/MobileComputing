extends AudioStreamPlayer

@export var default_enemy_sound : Array[AudioStreamWAV]
@export var button_pressed_stream : AudioStreamWAV

func play_expolosion() -> void:
	stream = default_enemy_sound.pick_random()
	pitch_scale = randf_range(0.6,0.9)
	play()

func play_default_pitch(audio : AudioStreamWAV):
	stream = audio
	pitch_scale = 1.0
	play()

func play_button_pressed():
	play_default_pitch(button_pressed_stream)
