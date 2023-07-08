extends Node

signal power_changed

var power : int = 0:
	get:
		return power
	set(value):
		power = clamp(value, 0, 10000)
		power_changed.emit()
