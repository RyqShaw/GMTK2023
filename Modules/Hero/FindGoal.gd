extends State

@onready var hero : CharacterBody2D = $"../.."
@onready var movement_target : Node2D = hero
@onready var navigation_agent: NavigationAgent2D = $"../../NavigationAgent2D"
@onready var sword_hitbox: Area2D = $"../../SwordHitbox"
@onready var animation_tree: AnimationTree = $"../../AnimationTree"
@onready var enemy_can_be_hit: Area2D = $"../../EnemyCanBeHit"
@onready var enemy_detection: Area2D = $"../../EnemyDetection"
@onready var update_timer: Timer = $"../../UpdateTimer"

func _ready() -> void:
	navigation_agent.path_desired_distance = 8.0
	navigation_agent.target_desired_distance = 8.0
	hero.level_info.shield_gen_removed.connect(update_movement_target)
	
	call_deferred("actor_setup")

func actor_setup() -> void:
	await get_tree().physics_frame
	update_movement_target()
	if movement_target == null:
		update_movement_target()
	else:
		set_movement_target(movement_target.global_position)

func set_movement_target(target: Vector2) -> void:
	navigation_agent.target_position = target

func _on_reset_nav_timeout() -> void:
	actor_setup()

func physics_update(delta):
	if navigation_agent.is_navigation_finished():
		update_movement_target()
		hero.velocity = hero.velocity.move_toward(Vector2.ZERO, hero.hero_stats.FRIC*delta)
	else:
		if movement_target != null:
			var current_agent_position := hero.global_position
			var next_path_position := navigation_agent.get_next_path_position()
			
			var new_vel := next_path_position - current_agent_position
			new_vel= new_vel.normalized()
			animation_tree.set("parameters/blend_position", new_vel)
			sword_hitbox.knockback_vector = new_vel
			new_vel = new_vel * hero.hero_stats.MAX_SPEED
			
			hero.velocity = hero.velocity.move_toward(new_vel, hero.hero_stats.ACCEL*delta)
		else:
			hero.velocity = hero.velocity.move_toward(Vector2.ZERO, hero.hero_stats.FRIC*delta)
	hero.move_and_slide()

func update_movement_target():
	if does_enemies_exist():
		var possible_targets = []
		for body in enemy_detection.get_overlapping_bodies():
			if body.is_in_group("EnemyMachine"):
				possible_targets.append(body)
		if not possible_targets.is_empty():
			var closest_target = possible_targets[0] 
			for target in possible_targets:
				if target.position.distance_to(hero.position) < closest_target.position.distance_to(hero.position):
					closest_target = target
			set_movement_target(closest_target.global_position)
			movement_target = closest_target
	elif GlobalInfo.shieldGenRunning > GlobalInfo.minShieldGen:
		if not hero.level_info.shield_generators.is_empty():
			var closest_target = hero.level_info.shield_generators[0]
			for target in hero.level_info.shield_generators:
				if navigation_agent.distance_to_target() < closest_target.position.distance_to(hero.position):
					closest_target = target
			set_movement_target(closest_target.global_position)
			movement_target = closest_target
	else:
		if hero.level_info.power_gen != null:
			movement_target = hero.level_info.power_gen
		else: 
			movement_target = hero
		set_movement_target(movement_target.global_position)
	return movement_target

func does_enemies_exist():
	if enemy_detection.has_overlapping_bodies():
		for body in enemy_detection.get_overlapping_bodies():
			if body.is_in_group("EnemyMachine"):
				return true
	return false
		
func _on_update_timer_timeout() -> void:
	update_movement_target()
