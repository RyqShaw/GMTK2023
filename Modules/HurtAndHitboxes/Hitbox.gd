extends Area2D

@export var weapon : HeroWeapon = preload("res://Modules/Hero/HeroWeapons/SwordWeapon.tres")
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

var damage : float = weapon.damage
var knockback_vector := Vector2.ZERO:
	get:
		return knockback_vector
	set(value):
		knockback_vector = value * weapon.knockback_scale

func _ready() -> void:
	collision_shape.disabled = true
