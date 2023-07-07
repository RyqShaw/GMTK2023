extends CharacterBody2D

@export var ACCEL = 250
@export var MAX_SPEED = 100
@export var FRIC = 400

@export var movement_target : Node
@onready var navigation_agent : NavigationAgent2D = $NavigationAgent2D

func _ready() -> void:
	navigation_agent.path_desired_distance = 4.0
	navigation_agent.target_desired_distance = 4.0 
	
	call_deferred("actor_setup")
	
func actor_setup() -> void:
	await get_tree().physics_frame
	
	set_movement_target(movement_target.position)

func set_movement_target(target: Vector2) -> void:
	navigation_agent.target_position = target
	
	
func _on_reset_nav_timeout() -> void:
	actor_setup()

func _physics_process(delta: float) -> void:
	
	if navigation_agent.is_navigation_finished():
		velocity = velocity.move_toward(Vector2.ZERO, FRIC*delta)
	else:
		var current_agent_position := global_position
		var next_path_position := navigation_agent.get_next_path_position()
		
		var new_vel := next_path_position - current_agent_position
		new_vel= new_vel.normalized()
		new_vel = new_vel * MAX_SPEED
		
		velocity = velocity.move_toward(new_vel, ACCEL*delta)
	move_and_slide()
