extends StaticBody2D


signal shrine_activated


var player_in_range: bool = false


func _ready() -> void:
	$Area2D.body_entered.connect(_on_body_entered)
	$Area2D.body_exited.connect(_on_body_exited)


func _process(_delta: float) -> void:
	if player_in_range and Input.is_action_just_pressed("interact"):
		shrine_activated.emit()


func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		player_in_range = true
		$Label.visible = true


func _on_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		player_in_range = false
		$Label.visible = false
