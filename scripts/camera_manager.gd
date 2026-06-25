class_name CameraManager
extends Node

@export var min_zoom: float = 6.0
@export var max_zoom: float = 10.5
@export var zoom_step: float = 0.4
@export var dash_dist: float = 3.0
@export var overhead_pcam: PhantomCamera3D
@export var character_pcam: PhantomCamera3D
@export var dash_pcam: PhantomCamera3D

var zoom_level: float = 8.0


func _ready() -> void:
	update_zoom_level()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed(&"zoom_in"):
		zoom_level = clamp(zoom_level - zoom_step, min_zoom, max_zoom)
		update_zoom_level()
	elif event.is_action_pressed(&"zoom_out"):
		zoom_level = clamp(zoom_level + zoom_step, min_zoom, max_zoom)
		update_zoom_level()


func activate_overhead():
	overhead_pcam.priority = 3


func deactivate_overhead():
	overhead_pcam.priority = 0


func update_zoom_level():
	character_pcam.follow_distance = zoom_level
	dash_pcam.follow_distance = zoom_level + dash_dist
