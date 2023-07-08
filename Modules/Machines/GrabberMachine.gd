extends CharacterBody2D

@export var cost : int = 10
@export var machine_stats : MachineStats
@onready var hurtbox: Area2D = $Hurtbox

func _ready() -> void:
	machine_stats.connect("no_health", func died(): queue_free())

func in_valid_spawn() -> void:
	if $InValidArea.has_overlapping_bodies() or $InValidArea.has_overlapping_areas() or cost > GlobalInfo.power:
		queue_free()
	else: 
		GlobalInfo.power -= cost

func _on_summoning_sickness_timeout() -> void:
	in_valid_spawn()

func _on_hurtbox_area_entered(area: Area2D) -> void:
	machine_stats.health -= area.damage
	hurtbox.start_invincibility(0.6)

func _on_hurtbox_invincibility_started() -> void:
	pass # Replace with function body.
	
func _on_hurtbox_invincibility_ended() -> void:
	pass # Replace with function body.

