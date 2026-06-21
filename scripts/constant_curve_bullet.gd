extends Bullet
class_name ConstantCurveBullet

var velocity : Vector3 = Vector3.ZERO
var curve_amount : float = 0.5

func _physics_process(delta: float) -> void:
	velocity = velocity.rotated(Vector3.UP, curve_amount * delta)
	position += velocity * delta
	super(delta)
