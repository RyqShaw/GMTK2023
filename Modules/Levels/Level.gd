extends Node2D

@export var interaction_controller = preload("res://Modules/PlayerControls/InteractionController.tres")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interaction_controller.world = $Ysort
	interaction_controller.tilemap = $MapTileset
