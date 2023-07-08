extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	text = "Power: 0"
	GlobalInfo.power_changed.connect(update_label)

func update_label() -> void:
	text = "Power: " + str(GlobalInfo.power)
