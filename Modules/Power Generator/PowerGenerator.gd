extends Node2D

func _on_power_timer_timeout():
	GlobalInfo.power = GlobalInfo.power + 10
