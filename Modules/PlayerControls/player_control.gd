extends Control

@export var interaction_controller = preload("res://Modules/PlayerControls/InteractionController.tres")

func _ready() -> void:
	interaction_controller.player_controller = self
	interaction_controller.creatures = $VBoxContainer/Creatures

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click_debug"):
		if interaction_controller.selected_button != null:
			if interaction_controller.world != null:
				var mouse_pos = interaction_controller.world.get_local_mouse_position()
				var instance = interaction_controller.selected_button.machine.instantiate()
				instance.position = mouse_pos
				interaction_controller.world.add_child(instance)
