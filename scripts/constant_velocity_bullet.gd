extends Bullet
class_name ConstantVelocityBullet

var velocity : Vector3 = Vector3.ZERO

func _physics_process(delta: float) -> void:
	super(delta)
	position += velocity * delta
