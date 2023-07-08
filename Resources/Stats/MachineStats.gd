extends Resource
class_name MachineStats

signal no_health
signal health_changed

@export var baseMachineLimit = 3
@export var grabberMachineLimit = 3
@export var treadMachineLimit = 3

var baseMachineNumber = 0
var grabberMachineNumber = 0
var treadMachineNumber = 0

@export var health = 10:
	get:
		return health
	set(value):
		health = value
		if health <= 0:
			no_health.emit()
			return
		health_changed.emit()
