extends StaticBody2D

@onready var hurtbox = $Hurtbox

@export var health = 100:
	set(value):
		health = value
		if health <= 0:
			shield_gen_destroyed()

func shield_gen_destroyed():
	GlobalInfo.shieldGenRunning -= GlobalInfo.shieldGenRunning - 1
	queue_free()

func _on_hurtbox_area_entered(area: Area2D) -> void:
	health -= area.damage
	hurtbox.start_invincibility(0.6)

func _on_hurtbox_invincibility_started() -> void:
	pass # Replace with function body.
	
func _on_hurtbox_invincibility_ended() -> void:
	pass # Replace with function body.
