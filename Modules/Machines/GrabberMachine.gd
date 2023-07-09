extends CharacterBody2D

@export var cost : int = 10
@export var machine_stats : MachineStats = MachineStats.new()
@export var acceleration = 300
@export var maxSpeed = 55
@export var friction = 200

@export var BULLET_SPEED = 5

@onready var hurtbox: Area2D = $Hurtbox
@onready var playerDetectionZone = $MachineSight

@onready var tread_machine: CharacterBody2D = $"."
@onready var movement_target : Node2D = GlobalInfo.hero
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@onready var update: Timer = $NavigationAgent2D/update

var bullet = preload("res://Modules/Machines/MachineWeapons/bomb.tscn")
var knockback = Vector2.ZERO
var player_visible := false
var can_shoot := true

func _ready() -> void:
	machine_stats.connect("no_health", died)
	
	navigation_agent.path_desired_distance = 40
	navigation_agent.target_desired_distance = 40
	
	call_deferred("actor_setup")
	
func actor_setup() -> void:
	await get_tree().physics_frame
	
	if movement_target != null:
		set_movement_target(movement_target.position)

func set_movement_target(target: Vector2) -> void:
	navigation_agent.target_position = target

func _physics_process(delta):
	if navigation_agent.is_navigation_finished():
		velocity = velocity.move_toward(Vector2.ZERO, friction*delta)
	else:
		var current_agent_position := global_position
		var next_path_position := navigation_agent.get_next_path_position()
		
		var new_vel := next_path_position - current_agent_position
		new_vel= new_vel.normalized()
		new_vel = new_vel * maxSpeed
		
		velocity = velocity.move_toward(new_vel, acceleration*delta)
	move_and_slide()
	if player_visible and can_shoot:
		fire()

func in_valid_spawn() -> void:
	if $InValidArea.has_overlapping_bodies() or $InValidArea.has_overlapping_areas() or cost > GlobalInfo.power or GlobalInfo.treadMachineNumber >= GlobalInfo.treadMachineLimit:
		queue_free()
	else: 
		GlobalInfo.power -= cost
		$CollisionShape2D.disabled = false
		GlobalInfo.treadMachineNumber += 1

func fire():
	var current_agent_position := global_position
	var next_path_position := navigation_agent.get_next_path_position()
		
	var new_vel := next_path_position - current_agent_position
	var bullet_insatnce = bullet.instantiate()
	bullet_insatnce.position = position
	bullet_insatnce.rotation_degrees = rad_to_deg(get_angle_to(movement_target.position))
	bullet_insatnce.apply_impulse((movement_target.position - position)*BULLET_SPEED)
	get_tree().get_root().call_deferred("add_child", bullet_insatnce)
	can_shoot = false
	$FireCooldown.start()

func _on_summoning_sickness_timeout() -> void:
	in_valid_spawn()

func _on_hurtbox_area_entered(area: Area2D) -> void:
	machine_stats.health -= area.damage
	hurtbox.start_invincibility(0.6)

func _on_hurtbox_invincibility_started() -> void:
	pass # Replace with function body.
	
func _on_hurtbox_invincibility_ended() -> void:
	pass # Replace with function body.

func died():
	queue_free()
	GlobalInfo.grabberMachineNumber -= 1

func _on_update_timeout() -> void:
	actor_setup()

func _on_machine_sight_body_entered(body: Node2D) -> void:
	player_visible = true

func _on_fire_cooldown_timeout() -> void:
	can_shoot = true

func _on_machine_sight_body_exited(body: Node2D) -> void:
	player_visible = false
