extends RigidBody2D

func _on_hitbox_area_entered(area: Area2D) -> void:
	queue_free()

func _on_timer_timeout() -> void:
	queue_free()
