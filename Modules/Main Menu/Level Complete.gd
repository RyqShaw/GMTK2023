extends Control

func _on_main_menu_pressed() -> void:
	get_tree().change_scene_to_packed(load("res://Modules/Main Menu/MainMenu.tscn"))
	queue_free()
