extends CharacterBody2D

@export var cost : int = 10
@export var machine_stats : MachineStats = MachineStats.new()
@export var acceleration = 300
@export var maxSpeed = 55
@export var friction = 200

@onready var hurtbox: Area2D = $Hurtbox
@onready var playerDetectionZone = $MachineSight
@onready var weapon = preload("res://Modules/Machines/MachineWeapons/Punch.tres")
enum {
	IDLE,
	CHASE
}

var knockback = Vector2.ZERO
var state = CHASE

func _ready() -> void:
	machine_stats.connect("no_health", died)
	state = IDLE
	machine_stats.health = 100
	$Hitbox.damage = weapon.damage

func in_valid_spawn() -> void:
	if $InValidArea.has_overlapping_bodies() or cost > GlobalInfo.power or GlobalInfo.baseMachineNumber >= GlobalInfo.baseMachineLimit:
		queue_free()
	else:
		GlobalInfo.power -= cost
		$CollisionShape2D.disabled = false
		GlobalInfo.baseMachineNumber += 1

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
	GlobalInfo.baseMachineNumber -= 1

func _physics_process(delta):
	match state:
		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
			seek_player()
			
		CHASE:
			var player = playerDetectionZone.player
			if player != null:
				accelerate_towards_point(player.global_position, delta)
			else:
				state = IDLE

func accelerate_towards_point(point, delta):
	var direction = global_position.direction_to(point)
	velocity = velocity.move_toward(direction * maxSpeed, acceleration * delta)
	move_and_slide()

func seek_player():
	if playerDetectionZone.can_see_player():
		state = CHASE

func pick_random_state(state_list):
	state_list.shuffle()
	return state_list.pop_front()

func _on_hitbox_area_entered(area: Area2D) -> void:
	velocity = (area.position - position)/4
