extends State


@onready var hero : CharacterBody2D = $"../.."
@onready var movement_target : Node = hero.movement_target
@onready var navigation_agent: NavigationAgent2D = $"../../NavigationAgent2D"
@onready var sword_hitbox: Area2D = $"../../SwordHitbox"
@onready var animation_tree: AnimationTree = $"../../AnimationTree"

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

func physics_update(delta):
	if navigation_agent.is_navigation_finished():
		hero.velocity = hero.velocity.move_toward(Vector2.ZERO, hero.hero_stats.FRIC*delta)
	else:
		var current_agent_position := hero.global_position
		var next_path_position := navigation_agent.get_next_path_position()
		
		var new_vel := next_path_position - current_agent_position
		new_vel= new_vel.normalized()
		animation_tree.set("parameters/blend_position", new_vel)
		sword_hitbox.knockback_vector = new_vel
		new_vel = new_vel * hero.hero_stats.MAX_SPEED
		
		hero.velocity = hero.velocity.move_toward(new_vel, hero.hero_stats.ACCEL*delta)
	hero.move_and_slide()
