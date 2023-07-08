extends State

@onready var hero : CharacterBody2D = $"../.."

func physics_update(delta):
	hero.velocity = hero.velocity * 0.8
	$"../../AnimationPlayer".play("Attack")
	hero.move_and_slide()
