extends Enemy

@export var max_height : float = 14
@export var min_height : float = 7
@onready var height_range : float = max_height - min_height
@export var height_curve : Curve
@export var activate_height: float = 9

@export var max_speed : float = 7
@export var min_speed : float = 4
@onready var speed_range : float = max_speed - min_speed
@export var speed_curve : Curve

# default right -> left
@export var mirror : bool = false

func get_arena_width():
	return LevelObjects.LevelManager.arena_size * 1.36

func calculate_pos(cur_x: float) -> Vector3:
	var x = get_sample_x(cur_x)
	var y = height_curve.sample(x)
	var height = min_height + (height_range * y)
	var vector = global_position
	vector.z = -height
	vector.x = cur_x
	return vector

func calculate_speed(cur_x) -> float:
	var x = get_sample_x(cur_x)
	var y = speed_curve.sample(x)
	return min_speed + (speed_range * y)

func get_sample_x(x) -> float:
	var arena_width = get_arena_width()
	var result = (x + (arena_width / 2)) / arena_width
	return result

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().process_frame
	self.position = calculate_pos(global_position.x)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var speed = calculate_speed(global_position.x)
	var mult = -1 if mirror else 1
	var x = global_position.x + speed * delta * mult
	var target_pos = calculate_pos(x)
	global_position = target_pos
	if -global_position.z < activate_height:
		propagate_call("activate")
	else:
		propagate_call("deactivate")
