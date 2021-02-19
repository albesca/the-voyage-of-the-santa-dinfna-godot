extends Node2D


export (PackedScene) var WaveScene
export (int) var waves_spacing
export (int) var waves_size
export (int) var waves_number
export (int) var waves_speed
export (float) var light_factor = 0.5;
var waves

# Called when the node enters the scene tree for the first time.
func _ready():
	init_waves()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func init_waves():
	waves = []
	var wave_position = Vector2(0, 0)
	while len(waves) < waves_number:
		var current_wave = WaveScene.instance()
		current_wave.amplitude = waves_size
		current_wave.speed = waves_speed
		current_wave.position = wave_position
		current_wave.light_factor = light_factor
		add_child(current_wave)
		wave_position += Vector2(0, waves_spacing)
		waves.append(current_wave)


func update_time(light_position, current_time):
	for wave in waves:
		wave.update_time(light_position, current_time)
