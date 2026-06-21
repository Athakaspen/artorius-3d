extends SimpleComponent
class_name RotateComponent

@export var rotate_speed : float = 0.5

func _process(delta: float) -> void:
	(parent as Node3D).rotate(Vector3.UP, rotate_speed * delta)
