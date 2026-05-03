extends Node2D


@onready var shrine: StaticBody2D = $Objects/Shrine
@onready var bgm: AudioStream = preload("res://assets/audio/bgm.mp3")
@onready var sfx_action: AudioStream = preload("res://assets/audio/click.wav")
@onready var sfx_coin: AudioStream = preload("res://assets/audio/pickupCoin.wav")
@onready var sfx_chrono: AudioStream = preload("res://assets/audio/powerUp.wav")
@onready var sfx_sapling: AudioStream = preload("res://assets/audio/random.wav")


signal trigger_ui_update


func reset() -> void:
	_refresh_world()
	$Monkey.position = Vector2(800, 290)


func _ready() -> void:
	shrine.shrine_activated.connect(_on_shrine_activated)
	var trees = $Trees.get_children()
	for tree in trees:
		tree.planted.connect(_on_tree_planted)
		tree.harvested.connect(_on_tree_harvested)
		tree.action_failed.connect(_on_action_failed)
	$NPCs/Capitalist.bananas_sold.connect(_on_bananas_sold)
	$NPCs/Capitalist.action_failed.connect(_on_action_failed)
	$NPCs/Farmer.sapling_purchased.connect(_on_sapling_purchased)
	$NPCs/Farmer.action_failed.connect(_on_action_failed)
	$NPCs/Business.plot_purchased.connect(_on_plot_purchased)
	$NPCs/Business.action_failed.connect(_on_action_failed)
	_refresh_world()
	Bgm.play(bgm)


func _refresh_world() -> void:
	$Objects/Barn.set_active(!GameState.is_future)
	$NPCs/Farmer.set_active(!GameState.is_future)
	$Objects/Stall.set_active(GameState.is_future)
	$NPCs/Capitalist.set_active(GameState.is_future)
	$Objects/Bank.set_active(!GameState.is_future)
	$NPCs/Business.set_active(!GameState.is_future)
	
	_update_trees()
	
	var trees = $Trees.get_children()
	for tree in trees:
		tree.toggle_state()


func _update_trees() -> void:
	var plots = $Trees.get_children()
	for i in 9:
		plots[i].set_active(i < GameState.plots)


func _on_shrine_activated() -> void:
	GameState.is_future = !GameState.is_future
	_refresh_world()
	trigger_ui_update.emit()
	$Monkey.play_animation("successful_action")
	Bgm.update_audio()
	Sfx.play(sfx_chrono)


func _on_tree_planted() -> void:
	trigger_ui_update.emit()
	$Monkey.play_animation("successful_action")


func _on_tree_harvested(amount: int) -> void:
	trigger_ui_update.emit()
	$Monkey.show_text("+" + str(amount) + " bananas")
	$Monkey.play_animation("successful_action")
	Sfx.play(sfx_action)


func _on_bananas_sold(value: int) -> void:
	trigger_ui_update.emit()
	$Monkey.show_text("+" + str(value) + " gold")
	$Monkey.play_animation("successful_action")
	Sfx.play(sfx_coin)


func _on_sapling_purchased() -> void:
	trigger_ui_update.emit()
	$Monkey.show_text("+1 sapling")
	$Monkey.play_animation("successful_action")
	Sfx.play(sfx_sapling)


func _on_plot_purchased() -> void:
	trigger_ui_update.emit()
	_update_trees()
	$Monkey.show_text("+1 plot")
	$Monkey.play_animation("successful_action")
	$Monkey.update_speed()


func _on_action_failed() -> void:
	$Monkey.play_animation("failed_action")
