extends CharacterBody2D

@export var cost : int = 10

func in_valid_spawn() -> void:
	if $InValidArea.has_overlapping_bodies() or $InValidArea.has_overlapping_areas() or cost > GlobalInfo.power:
		print($InValidArea.get_overlapping_bodies())
		queue_free()
	else: 
		GlobalInfo.power -= cost
		print(GlobalInfo.power)
		print("valid")

func _on_summoning_sickness_timeout() -> void:
	in_valid_spawn()
