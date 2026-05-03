extends CanvasLayer


@onready var money = $GameUI/HBoxContainer/StatsContainer/MoneyContainer/MoneyValue
@onready var tree = $GameUI/HBoxContainer/StatsContainer/TreeContainer/TreeValue
@onready var banana = $GameUI/HBoxContainer/StatsContainer/BananaContainer/BananaValue
@onready var year = $GameUI/HBoxContainer/InfoContainer/YearContainer/YearValue


func show_start_screen() -> void:
	$GameUI.visible = false
	$StartScreen.visible = true
	$WinScreen.visible = false
	GameState.is_game_screen = false


func show_game_screen() -> void:
	if GameState.is_game_screen:
		return
	$GameUI.visible = true
	$StartScreen.visible = false
	$WinScreen.visible = false
	GameState.is_game_screen = true


func show_win_screen() -> void:
	$GameUI.visible = false
	$StartScreen.visible = false
	$WinScreen.visible = true
	GameState.is_game_screen = false


func update() -> void:
	money.text = str(GameState.money)
	tree.text = str(GameState.saplings)
	banana.text = str(GameState.bananas)
	if GameState.is_future:
		year.text = str(2162)
		$GameUI/ColorRect.color = Color(0.4, 0.2, 0.6, 0.2)
	else:
		year.text = str(2144)
		$GameUI/ColorRect.color = Color(0, 0, 0, 0)
