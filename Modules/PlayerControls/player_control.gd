extends Control

@export var interaction_controller = preload("res://Modules/PlayerControls/InteractionController.tres")

var mouse_not_in_area := true
@onready var machine_instance_button: Button = $VBoxContainer/Creatures/MachineInstanceButton
@onready var machine_instance_button_2: Button = $VBoxContainer/Creatures/MachineInstanceButton2
@onready var machine_instance_button_3: Button = $VBoxContainer/Creatures/MachineInstanceButton3
@onready var deselect: Button = $VBoxContainer/Creatures/Deselect

func _ready() -> void:
	interaction_controller.player_controller = self
	interaction_controller.creatures = $VBoxContainer/Creatures
	interaction_controller.selected_button = $VBoxContainer/Creatures/Deselect
	
	machine_instance_button.mouse_entered.connect(mouse_in_area)
	machine_instance_button_2.mouse_entered.connect(mouse_in_area)
	machine_instance_button_3.mouse_entered.connect(mouse_in_area)
	deselect.mouse_entered.connect(mouse_in_area)
	
	machine_instance_button.mouse_exited.connect(mouse_left_area)
	machine_instance_button_2.mouse_exited.connect(mouse_left_area)
	machine_instance_button_3.mouse_exited.connect(mouse_left_area)
	deselect.mouse_exited.connect(mouse_left_area)
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click_debug"):
		if interaction_controller.selected_button != null:
			if interaction_controller.world != null and mouse_not_in_area and interaction_controller.selected_button.machine != null:
				var mouse_pos = interaction_controller.world.get_local_mouse_position()
				var instance = interaction_controller.selected_button.machine.instantiate()
				instance.position = mouse_pos
				interaction_controller.world.add_child(instance)


func mouse_in_area() -> void:
	mouse_not_in_area = false

func mouse_left_area() -> void:
	mouse_not_in_area = true
