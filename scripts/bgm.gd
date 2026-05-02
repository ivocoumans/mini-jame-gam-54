extends Node

@export var fade_time: float = 0.2

var player: AudioStreamPlayer
var tween: Tween


func _ready() -> void:
	player = AudioStreamPlayer.new()
	player.bus = "BGM"
	add_child(player)


func play(stream: AudioStream) -> void:
	if not stream or (player.stream == stream and player.playing):
		return
	player.stream = stream
	update_audio()
	player.play()


func update_audio() -> void:
	var bus: int = AudioServer.get_bus_index("BGM")
	var reverb: AudioEffectReverb = AudioServer.get_bus_effect(bus, 0) as AudioEffectReverb
	
	if GameState.is_future:
		player.pitch_scale = 0.87
		player.volume_db = -2
		reverb.wet = 0.4
	else:
		player.pitch_scale = 0.90
		player.volume_db = 0
		reverb.wet = 0.15


func stop() -> void:
	player.stop()
