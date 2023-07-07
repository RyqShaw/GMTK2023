extends Control

@export var interaction_controller = preload("res://Modules/PlayerControls/InteractionController.tres")

func _ready() -> void:
	interaction_controller.player_controller = self
	interaction_controller.creatures = $VBoxContainer/Creatures
	print(interaction_controller.creatures)
