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
	
	machine_instance_button.connect("mouse_entered", mouse_in_area)
	machine_instance_button_2.connect("mouse_entered", mouse_in_area)
	machine_instance_button_3.connect("mouse_entered", mouse_in_area)
	deselect.connect("mouse_entered", mouse_in_area)
	
	machine_instance_button.connect("mouse_exited", mouse_left_area)
	machine_instance_button_2.connect("mouse_exited", mouse_left_area)
	machine_instance_button_3.connect("mouse_exited", mouse_left_area)
	deselect.connect("mouse_exited", mouse_left_area)
	

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("left_click_debug") and mouse_not_in_area and interaction_controller.selected_button.machine != null:
		if interaction_controller.selected_button != null:
			if interaction_controller.world != null:
				var mouse_pos = interaction_controller.world.get_local_mouse_position()
				var instance = interaction_controller.selected_button.machine.instantiate()
				instance.position = mouse_pos
				interaction_controller.world.add_child(instance)


func mouse_in_area() -> void:
	mouse_not_in_area = false

func mouse_left_area() -> void:
	mouse_not_in_area = true
