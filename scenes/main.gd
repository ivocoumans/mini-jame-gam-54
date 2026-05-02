extends Node2D

@onready var shrine: StaticBody2D = $Objects/Shrine


func _ready() -> void:
	if OS.is_debug_build():
		GameState.money = 99999
		GameState.bananas = 999
		GameState.saplings = 999
		GameState.plots = 9
	
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
	$UI.update()
	_refresh_world()


func _refresh_world() -> void:
	$Objects/Barn.set_active(GameState.is_future)
	$NPCs/Farmer.set_active(GameState.is_future)
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
	$UI.update()
	$Monkey.play_animation("successful_action")


func _on_tree_planted() -> void:
	$UI.update()
	$Monkey.play_animation("successful_action")


func _on_tree_harvested(amount: int) -> void:
	$UI.update()
	$Monkey.show_text("+" + str(amount) + " bananas")
	$Monkey.play_animation("successful_action")


func _on_bananas_sold(value: int) -> void:
	$UI.update()
	$Monkey.show_text("+" + str(value) + " gold")
	$Monkey.play_animation("successful_action")


func _on_sapling_purchased() -> void:
	$UI.update()
	$Monkey.show_text("+1 sapling")
	$Monkey.play_animation("successful_action")


func _on_plot_purchased() -> void:
	$UI.update()
	_update_trees()
	$Monkey.show_text("+1 plot")
	$Monkey.play_animation("successful_action")


func _on_action_failed() -> void:
	$Monkey.play_animation("failed_action")


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
