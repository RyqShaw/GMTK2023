extends Resource
class_name HeroStats

signal no_health
signal health_changed

@export var ACCEL = 250
@export var MAX_SPEED = 100
@export var FRIC = 400

@export var health = 10:
	get:
		return health
	set(value):
		health = value
		if health <= 0:
			no_health.emit()
			return
		health_changed.emit()
