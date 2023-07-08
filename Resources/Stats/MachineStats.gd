extends Resource
class_name MachineStats

signal no_health
signal health_changed

@export var health = 10:
	get:
		return health
	set(value):
		health = value
		if health <= 0:
			print("a little closer")
			no_health.emit()
			return
		health_changed.emit()
