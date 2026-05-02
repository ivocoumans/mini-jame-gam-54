extends CharacterBody2D

@export var move_speed: float = 175.0

@onready var text_label: Label = $Label

var text_tween: Tween


func play_animation(animation_name: String) -> void:
	$AnimatedSprite2D.play(animation_name)


func show_text(message: String, duration: float = 2.0) -> void:
	if text_tween:
		text_tween.kill()
	
	# show text
	text_label.text = message
	text_label.visible = true
	text_label.modulate.a = 1.0
	text_tween = create_tween()

	# fade out
	text_tween.tween_interval(duration)
	text_tween.tween_property(text_label, "modulate:a", 0.0, 0.3)
	text_tween.tween_callback(_hide_text)


func _hide_text() -> void:
	text_label.visible = false


func _ready() -> void:
	add_to_group("player")


func _physics_process(_delta: float) -> void:
	var input_direction: Vector2 = Vector2.ZERO
	input_direction.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_direction.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")
	input_direction = input_direction.normalized()
	velocity = input_direction * move_speed
	if velocity != Vector2.ZERO:
		$AnimatedSprite2D.play("walk")
	move_and_slide()
