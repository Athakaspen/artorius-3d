class_name RotateComponent
extends SimpleComponent

@export var rotate_speed: float = 0.5
@export var randomize_start: bool = false


func _ready() -> void:
	if (randomize_start):
		(parent as Node3D).rotate(Vector3.UP, randf_range(0, 100))


func _process(delta: float) -> void:
	(parent as Node3D).rotate(Vector3.UP, rotate_speed * delta)
