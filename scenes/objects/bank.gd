extends StaticBody2D


func set_active(is_active: bool) -> void:
	visible = is_active
	$CollisionShape2D.disabled = !is_active
