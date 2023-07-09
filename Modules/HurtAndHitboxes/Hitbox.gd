extends Area2D

@export var weapon : HeroWeapon
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

@export var disabled_by_default := true

var damage : float
var knockback_vector := Vector2.ZERO:
	get:
		return knockback_vector
	set(value):
		knockback_vector = value * weapon.knockback_scale

func _ready() -> void:
	damage = weapon.damage
	collision_shape.disabled = disabled_by_default
