extends Enemy

@export var move_dir : Vector3 = Vector3.ZERO
@export var move_speed : float = 3.0

func _ready() -> void:
	self.velocity = move_dir * move_speed

func _physics_process(delta: float) -> void:
	move_and_slide()

func on_dead():
	pass
