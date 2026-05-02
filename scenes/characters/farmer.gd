extends Area2D


signal sapling_purchased
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
	if player_in_range:
		if Input.is_action_just_pressed("interact"):
			_buy_sapling()
		if Input.is_action_just_pressed("interact_alt"):
			_buy_all_saplings()


func _buy_sapling() -> void:
	var cost: int = GameState.get_sapling_cost()
	if GameState.money < cost:
		action_failed.emit()
		return

	GameState.saplings += 1
	GameState.money -= cost
	sapling_purchased.emit()
	_update_text()


func _buy_all_saplings() -> void:
	var cost: int = GameState.get_sapling_cost()
	var max_purchase: int = floor(float(GameState.money) / cost)
	var max_amount: int = min(max_purchase, GameState.plots)
	var max_cost: int = max_amount * cost
	if GameState.money < max_cost:
		action_failed.emit()
		return

	GameState.saplings += max_amount
	GameState.money -= max_cost
	sapling_purchased.emit()
	_update_text()


func _update_text() -> void:
	if player_in_range:
		var cost: int = GameState.get_sapling_cost()
		if GameState.money >= cost:
			var max_purchase: int = floor(float(GameState.money) / cost)
			var max_amount: int = min(max_purchase, GameState.plots)
			var max_cost: int = max_amount * cost
			var buy_all_string: String = ""
			if max_amount > 1:
				buy_all_string = "\n[F] Buy " + str(max_amount) + " saplings for " + str(max_cost) + " gold?"
			$Label.text = "[E] Buy sapling for " + str(cost) + " gold?" + buy_all_string
		else:
			$Label.text = "Need " + str(cost) + " gold to buy sapling"
	$Label.visible = player_in_range


func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		player_in_range = true
		_update_text()


func _on_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		player_in_range = false
		_update_text()
