extends CharacterBody2D

signal weapon_changed

@export var hero_stats : HeroStats
@export var weapon : HeroWeapon = preload("res://Modules/Hero/HeroWeapons/SwordWeapon.tres"):
	get:
		return weapon
	set(value):
		weapon = value
		weapon_changed.emit()

@export var movement_target : Node2D
@onready var navigation_agent : NavigationAgent2D = $NavigationAgent2D
@onready var hurtbox: Area2D = $Hurtbox

func _ready() -> void:
	self.connect("weapon_changed", set_attack_mode)
	#hero_stats.connect("health_changed", update_health)
	hero_stats.connect("no_health", hero_dead)

func _physics_process(_delta: float) -> void:
	pass

func set_attack_mode() -> void:
	pass

func _on_hurtbox_area_entered(area: Area2D) -> void:
	hero_stats.health -= area.damage
	hurtbox.start_invincibility(0.6)

func _on_hurtbox_invincibility_started() -> void:
	pass # Replace with function body.

func _on_hurtbox_invincibility_ended() -> void:
	pass # Replace with function body.

func hero_dead():
	get_tree().quit()
