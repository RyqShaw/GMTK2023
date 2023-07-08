extends Button

@export var interaction_controller = preload("res://Modules/PlayerControls/InteractionController.tres")
@export var machine := preload("res://Modules/Machines/BaseMachine.tscn")

func _on_pressed() -> void:
	interaction_controller.selected_button = self
	if interaction_controller.creatures != null:
		for node in interaction_controller.creatures.get_children():
			node.disabled = false
	self.disabled = true
