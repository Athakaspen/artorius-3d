extends Bullet
class_name DirectionSpeedBullet

@export var direction : Vector3 = Vector3.FORWARD
@export var speed : float = 7

func _ready() -> void:
	if not is_equal_approx(direction.length_squared(), 1):
		print ("bullet has sus direction")
	if not is_zero_approx(direction.y):
		print ("bullet has sus verticality")

func _physics_process(delta: float) -> void:
	position += direction * speed * delta
	super(delta)
