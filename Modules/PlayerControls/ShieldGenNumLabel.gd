extends Label

func _ready() -> void:
	var running := "Shield Generators Running: " + str(GlobalInfo.shieldGenRunning)
	var mina := "Min Generators Needed: " + str(GlobalInfo.minShieldGen + 1)
	text = running + "\n" + mina
	GlobalInfo.shield_gen_running_changed.connect(update_label)

func update_label() -> void:
	var running := "Shield Generators Running: " + str(GlobalInfo.shieldGenRunning)
	var mina := "Min Generators Needed: " + str(GlobalInfo.minShieldGen + 1)
	text = running + "\n" + mina
