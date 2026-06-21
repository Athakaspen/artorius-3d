extends BulletComponent
class_name BendTrajectory

@export var curve_amount : float

func _physics_process(delta: float) -> void:
	parent_bullet.direction = parent_bullet.direction.rotated(Vector3.UP, curve_amount * delta)
