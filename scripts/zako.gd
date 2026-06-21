extends Enemy

@onready var parent : Node3D = get_parent()

@export var max_speed : float = 6.0
@export var acceleration : float = 5.0
@export var randomness : float = 1.0

func _ready() -> void:
	velocity = Globals.random_vector_flat() * max_speed

func _physics_process(delta: float) -> void:
	var target_pos = parent.global_position
	var accel_dir = target_pos - global_position
	velocity += accel_dir * acceleration * delta
	
	velocity.y = 0
	velocity.limit_length(max_speed)
	
	move_and_slide()
