extends Control


func _on_go_back_pressed() -> void:
	get_tree().change_scene_to_packed(load("res://Modules/Main Menu/MainMenu.tscn"))


func level1() -> void:
	get_tree().change_scene_to_packed(load("res://Modules/Levels/Level1.tscn"))
