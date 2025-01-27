extends AudioStreamPlayer

@export var hit_stream : AudioStreamWAV
@export var death_stream : AudioStreamWAV

func play_hit():
	stream = hit_stream
	play()

func play_death():
	if playing && stream == death_stream: return
	stream = death_stream
	play()
