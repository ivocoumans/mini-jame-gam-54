extends Area2D


signal bananas_sold(value: int)
signal action_failed


var player_in_range: bool = false


func set_active(is_active: bool) -> void:
	visible = is_active
	monitoring = is_active


func _ready() -> void:
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	_update_text()


func _process(_delta: float) -> void:
	if player_in_range and Input.is_action_just_pressed("interact"):
		_sell_all_bananas()


func _sell_all_bananas() -> void:
	if GameState.bananas <= 0:
		action_failed.emit()
		return

	var total: int = GameState.bananas * GameState.get_banana_value()
	GameState.money += total
	GameState.bananas = 0
	bananas_sold.emit(total)
	_update_text()


func _update_text() -> void:
	if player_in_range:
		var value: int = GameState.get_banana_value()
		var total: int = GameState.bananas * value
		if GameState.bananas > 0:
			$Label.text = "Sell all bananas for " + str(total) + " gold?"
		else:
			$Label.text = "Bring bananas to sell for " + str(value) + " gold each"
	$Label.visible = player_in_range


func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		player_in_range = true
		_update_text()


func _on_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		player_in_range = false
		_update_text()
