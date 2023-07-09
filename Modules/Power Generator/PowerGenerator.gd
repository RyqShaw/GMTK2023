extends StaticBody2D

@onready var hurtbox = $Hurtbox

@export var health = 100:
	set(value):
		health = value
		if health <= 0:
			queue_free()

func _ready() -> void:
	GlobalInfo.shield_gen_running_changed.connect(shield_gen_down)
	hurtbox.set_deferred("monitorable", false)

func _on_power_timer_timeout():
	GlobalInfo.power = GlobalInfo.power + 10

func shield_gen_down():
	if GlobalInfo.shieldGenRunning <= GlobalInfo.minShieldGen:
		hurtbox.set_deferred("monitorable", true)

func _on_hurtbox_area_entered(area: Area2D) -> void:
	health -= area.damage
	hurtbox.start_invincibility(0.6)

func _on_hurtbox_invincibility_started() -> void:
	pass # Replace with function body.
	
func _on_hurtbox_invincibility_ended() -> void:
	pass # Replace with function body.
