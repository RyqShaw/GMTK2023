extends CharacterBody2D

@export var enemy_stats : EnemyStats

@export var movement_target : Node
@onready var navigation_agent : NavigationAgent2D = $NavigationAgent2D

func _physics_process(delta: float) -> void:
	pass
