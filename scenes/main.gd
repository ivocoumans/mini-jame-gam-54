extends Node2D


func _ready() -> void:
	$UI.update()
	$UI.show_start_screen()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
	elif !GameState.is_game_screen and event.is_action_pressed("interact"):
		GameState.reset()
		$World.reset()
		$UI.show_game_screen()
		$UI.update()


func _on_world_trigger_ui_update():
	$UI.update()
	if GameState.plots >= 9:
		$UI.show_win_screen()
