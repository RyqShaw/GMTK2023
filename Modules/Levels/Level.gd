extends Node2D

@export var level_info : LevelInfo
@export var interaction_controller = preload("res://Modules/PlayerControls/InteractionController.tres")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interaction_controller.world = $Ysort
	interaction_controller.tilemap = $MapTileset
	level_info.power_gen = $Ysort/PowerGenerator
	for gen in $Ysort/ShieldGenerators.get_children():
		level_info.shield_generators.append(gen)
		gen.tree_exiting.connect(set_shield_gens)

func set_shield_gens():
	level_info.shield_generators = []
	for gen in $Ysort/ShieldGenerators.get_children():
		if not gen.is_queued_for_deletion(): level_info.shield_generators.append(gen)
