extends Label

func _ready() -> void:
	var running := "Shield Generators Running: " + str(GlobalInfo.shieldGenRunning)
	var min := "Min Generators Needed: " + str(GlobalInfo.minShieldGen)
	text = running + "\n" + min
	GlobalInfo.shield_gen_running_changed.connect(update_label)

func update_label() -> void:
	var running := "Shield Generators Running: " + str(GlobalInfo.shieldGenRunning)
	var min := "Min Generators Needed: " + str(GlobalInfo.minShieldGen)
	text = running + "\n" + min
