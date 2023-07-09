extends Control

func _on_retry_pressed() -> void:
	get_tree().reload_current_scene()
	queue_free()


func _on_level_select_pressed() -> void:
	get_tree().change_scene_to_packed(load("res://Modules/Main Menu/MainMenu.tscn"))
	queue_free()
