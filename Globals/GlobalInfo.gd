extends Node

signal power_changed
signal base_machine_num_changed
signal grabber_machine_num_changed
signal tread_machine_num_changed
signal shield_gen_running_changed

@export var baseMachineLimit = 10
@export var grabberMachineLimit = 10
@export var treadMachineLimit = 10
@export var minShieldGen = 2

var resetbaseMachineLimit = baseMachineLimit
var resetgrabberMachineLimit = grabberMachineLimit
var resettreadMachineLimit = treadMachineLimit
var resetminShieldGen = minShieldGen


var hero : Node2D = null:
	set(value):
		hero = value
		if hero != null:
			hero.died.connect(reset)
var pow_gen : Node2D = null:
	set(value):
		pow_gen = value
		if pow_gen != null:
			pow_gen.died.connect(reset)

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

@export var shieldGenRunning = 4:
	set(value):
		shieldGenRunning = value
		shield_gen_running_changed.emit()

var power : int = 0:
	get:
		return power
	set(value):
		power = clamp(value, 0, 10000)
		power_changed.emit()

func reset():
	baseMachineLimit = resetbaseMachineLimit
	grabberMachineLimit = resetgrabberMachineLimit
	treadMachineLimit = resettreadMachineLimit
	minShieldGen = resetminShieldGen
	
	shieldGenRunning = 4
	baseMachineNumber = 0
	grabberMachineNumber = 0
	treadMachineNumber = 0
