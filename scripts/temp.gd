extends Node

@onready var tim: CharacterBody3D = %Tim

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event):
	if event is InputEventMouseMotion:
		var camera3d = get_viewport().get_camera_3d()
		var origin = camera3d.project_ray_origin(event.position)
		var direction = camera3d.project_ray_normal(event.position)
		
		var len = -(origin.y - tim.position.y) / direction.y
		var point = origin + direction * len
		$"../markersphere".position = point
