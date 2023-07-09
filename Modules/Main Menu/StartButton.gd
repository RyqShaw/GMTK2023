extends Button

func _on_pressed():
	get_tree().change_scene_to_packed(load("res://Modules/Levels/Level1.tscn"))
