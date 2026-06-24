extends Node

@export var min_distance: float = 0.5
@export var max_distance: float = 12
@export var max_charge_time: float = 1.1
@export var charge_time_dist_curve: Curve
@export var max_rotate_speed: float = 1.0
@export var shape_cast: ShapeCast3D

## current charge level, from 0 to 1
var charge_amount: float = 0.0
var active: bool = false
var charge_time: float = 0.0
var dash_aim_point: Vector3
var dash_target_point: Vector3
var aim_with_mouse: bool = false
var mouse_aim_point: Vector3 = Vector3.ZERO

@onready var tim: CharacterBody3D = $"../.."
@onready var distance_range = max_distance - min_distance


func _process(delta: float) -> void:
	if !active:
		return
	charge_time += delta
	charge_amount = min(1.0, charge_time / max_charge_time)

	var slerp_speed: float
	if !aim_with_mouse:
		var vec2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		if vec2 == Vector2.ZERO:
			vec2 = Vector2.UP
		dash_aim_point = tim.position + Vector3(vec2.x, 0, vec2.y)
		slerp_speed = 6
	else:
		slerp_speed = 18

	var input_direction = (dash_aim_point - tim.position).normalized()
	var direction
	if charge_time > 0.1:
		var cur_direction = (dash_target_point - tim.position).normalized()
		direction = cur_direction.slerp(input_direction, slerp_speed * delta)
	else:
		direction = input_direction

	var scaled_charge_amount = charge_time_dist_curve.sample(charge_amount)
	var distance = min_distance + scaled_charge_amount * distance_range
	var dash_vector = distance * direction

	shape_cast.target_position = dash_vector
	shape_cast.force_shapecast_update()
	var fraction = shape_cast.get_closest_collision_safe_fraction()

	dash_target_point = tim.global_position + dash_vector * fraction

	%PlayerSubtree.propagate_call("on_dash_point_update", [dash_target_point])


func on_dash_pressed():
	active = true
	charge_time = 0
	aim_with_mouse = false
	dash_target_point = tim.global_position
	$"../../../../ThirdPersonCam2".priority = 2


func on_dash_released():
	if !active:
		print("Finish dash while not dashing!")
		return
	$"../../../../ThirdPersonCam2".priority = 0

	tim.translate(dash_target_point - tim.position)
	active = false
	charge_amount = 0
	%PlayerSubtree.propagate_call("on_dash_performed")


func on_mouse_move(point: Vector3):
	if !active:
		return
	aim_with_mouse = true
	dash_aim_point = point
