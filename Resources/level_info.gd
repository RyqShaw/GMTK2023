extends Resource
class_name LevelInfo

signal shield_gen_removed

var hero = null
var power_gen = null
var shield_generators = []:
	set(value):
		shield_generators = value
		shield_gen_removed.emit()
