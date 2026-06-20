extends Node

@onready var tim: CharacterBody3D = $"../.."

@export var min_distance : float = 0.5
@export var max_distance : float = 12
@onready var distance_range = max_distance - min_distance
@export var max_charge_time : float = 1.1

@export var charge_time_dist_curve : Curve

## current charge level, from 0 to 1
var charge_amount : float = 0.0

var active : bool = false
var charge_time : float = 0.0
var dash_aim_point : Vector3
var dash_target_point : Vector3

var aim_with_mouse : bool = false
var mouse_aim_point : Vector3 = Vector3.ZERO

func _process(delta: float) -> void:
	if !active: return
	charge_time += delta
	charge_amount = min(1.0, charge_time / max_charge_time)
	
	if !aim_with_mouse:
		var vec2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		if vec2 == Vector2.ZERO: vec2 = Vector2.UP
		dash_aim_point = tim.position + Vector3(vec2.x, 0, vec2.y)
	
	var direction = (dash_aim_point - tim.position).normalized()
	var scaled_charge_amount = charge_time_dist_curve.sample(charge_amount)
	var distance = min_distance + scaled_charge_amount * distance_range
	var dash_vector = distance * direction
	dash_target_point = tim.global_position + dash_vector
	
	%PlayerSubtree.propagate_call("on_dash_point_update", [dash_target_point])

func on_dash_pressed():
	active = true
	charge_time = 0
	aim_with_mouse = false

func on_dash_released():
	if !active: 
		print("Finish dash while not dashing!")
		return
	
	tim.translate(dash_target_point - tim.position)
	
	active = false
	charge_amount = 0

func on_mouse_move(point: Vector3):
	if !active: return
	aim_with_mouse = true
	dash_aim_point = point
