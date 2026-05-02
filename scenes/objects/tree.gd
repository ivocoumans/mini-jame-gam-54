extends StaticBody2D

enum TreeState {
	EMPTY,
	SAPLING,
	HARVEST,
}

signal planted
signal harvested(amount: int)

@onready var sprite_top: Sprite2D = $SpriteTop
@onready var sprite_bottom: Sprite2D = $SpriteBottom

@export var state = TreeState.EMPTY

var region_size: Vector2 = Vector2(64, 128)
var player_in_range: bool = false


func toggle_state() -> void:
	if state == TreeState.SAPLING and GameState.is_future == true:
		_set_state(TreeState.HARVEST)
	elif state == TreeState.HARVEST and GameState.is_future == false:
		_set_state(TreeState.SAPLING)


func set_active(is_active: bool) -> void:
	visible = is_active
	$CollisionShape2D.disabled = !is_active
	$Area2D.monitoring = is_active


func _ready() -> void:
	_update_sprite_region()
	$Area2D.body_entered.connect(_on_body_entered)
	$Area2D.body_exited.connect(_on_body_exited)


func _process(_delta: float) -> void:
	if player_in_range and Input.is_action_just_pressed("interact"):
		if state == TreeState.EMPTY and GameState.saplings > 0 and GameState.is_future == false:
			GameState.saplings = GameState.saplings - 1
			state = TreeState.SAPLING
			_update_sprite_region()
			planted.emit()
		elif state == TreeState.HARVEST and GameState.is_future == true:
			var amount: int = GameState.get_banana_yield()
			GameState.bananas = GameState.bananas + amount
			state = TreeState.EMPTY
			_update_sprite_region()
			harvested.emit(amount)


func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		player_in_range = true


func _on_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		player_in_range = false


func _set_state(new_state: TreeState) -> void:
	state = new_state
	_update_sprite_region()


func _update_sprite_region() -> void:
	var index = int(state)
	var region_position: Vector2 = Vector2(region_size.x * index, 0)
	sprite_top.region_rect = Rect2(region_position, region_size)
	sprite_bottom.region_rect = Rect2(region_position, region_size)
