extends Node

signal power_changed
signal base_machine_num_changed
signal grabber_machine_num_changed
signal tread_machine_num_changed

@export var baseMachineLimit = 3
@export var grabberMachineLimit = 3
@export var treadMachineLimit = 3

var baseMachineNumber = 0:
	set(value):
		baseMachineNumber = value
		base_machine_num_changed.emit()
var grabberMachineNumber = 0:
	set(value):
		grabberMachineNumber = value
		grabber_machine_num_changed.emit()
var treadMachineNumber = 0:
	set(value):
		treadMachineNumber = value
		tread_machine_num_changed.emit()

var power : int = 0:
	get:
		return power
	set(value):
		power = clamp(value, 0, 10000)
		power_changed.emit()
