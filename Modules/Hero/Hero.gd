extends CharacterBody2D

@export var hero_stats : HeroStats

@export var movement_target : Node
@onready var navigation_agent : NavigationAgent2D = $NavigationAgent2D

func _physics_process(delta: float) -> void:
	pass
