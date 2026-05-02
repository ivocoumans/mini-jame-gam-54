extends Node


var players: Array[AudioStreamPlayer] = []
var index: int = 0


func _ready() -> void:
	for i in 8:
		var p := AudioStreamPlayer.new()
		p.bus = "SFX"
		add_child(p)
		players.append(p)


func play(stream: AudioStream) -> void:
	if not stream:
		return

	var p: AudioStreamPlayer = players[index]
	index = (index + 1) % players.size()

	p.stop()
	p.stream = stream
	p.play()
