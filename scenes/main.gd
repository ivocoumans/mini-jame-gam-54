extends Node2D


func _ready() -> void:
	$UI.update()
	$UI.show_start_screen()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
	elif !GameState.is_game_screen and event.is_action_pressed("interact"):
		$UI.show_game_screen()


func _on_world_trigger_ui_update():
	$UI.update()
