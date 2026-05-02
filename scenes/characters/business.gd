extends Area2D


signal plot_purchased
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
		_buy_plot()


func _buy_plot() -> void:
	var cost: int = GameState.get_plot_cost()
	if GameState.money < cost or GameState.plots >= GameState.max_plots:
		action_failed.emit()
		return

	GameState.money -= cost
	GameState.plots += 1
	plot_purchased.emit()
	_update_text()


func _update_text() -> void:
	if player_in_range:
		var cost: int = GameState.get_plot_cost()
		if GameState.plots >= GameState.max_plots:
			$Label.text = "No more plots available!"
		elif GameState.money >= cost:
			$Label.text = "[E] Buy plot for " + str(cost) + " gold?"
		else:
			$Label.text = "Need " + str(cost) + " gold to buy plot"
	$Label.visible = player_in_range


func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		player_in_range = true
		_update_text()


func _on_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		player_in_range = false
		_update_text()
