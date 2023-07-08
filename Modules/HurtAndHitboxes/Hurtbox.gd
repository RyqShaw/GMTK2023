extends Area2D

signal invincibility_started
signal invincibility_ended

@onready var timer = $Timer
@onready var collisionShape = $CollisionShape2D

var invincible = false:
	get:
		return invincible
	set(value):
		invincible = value
		if invincible == true:
			invincibility_started.emit()
		else:
			invincibility_ended.emit()

func start_invincibility(duration):
	self.invincible = true
	timer.start(duration)

func _on_Timer_timeout():
	self.invincible = false

func _on_HurtBox_invincibility_started():
	collisionShape.set_deferred("disabled", true)
	
func _on_HurtBox_invincibility_ended():
	collisionShape.set_deferred("disabled", false)
