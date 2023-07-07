extends Marker2D

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click_debug"):
		global_position = get_global_mouse_position()
