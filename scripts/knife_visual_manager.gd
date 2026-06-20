extends Node

@export var mesh_holder : Node3D
@export var mesh : MeshInstance3D

var spin_speed_normal = 7
var spin_speed_focus = 15
var spin_speed_fly = 30

@onready var knife : Knife = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match knife.state:
		Knife.SPIN:
			animate_spin(delta)
		Knife.DASH_CHARGE:
			animate_dash_charge(delta)
		Knife.DASH_FLY:
			animate_dash_fly(delta)

func animate_spin(delta: float) -> void:
	var is_focusing = %Tim.is_focusing
	var spin_speed = spin_speed_focus if is_focusing else spin_speed_normal
	mesh_holder.rotate(Vector3.LEFT, -delta * spin_speed)

var aim_point := Vector3.ZERO
func animate_dash_charge(delta: float) -> void:
	var offset = knife.follow_point.global_position - %Tim.global_position
	aim_point = dash_target + offset
	mesh_holder.look_at(aim_point)

func animate_dash_fly(delta: float) -> void:
	mesh_holder.rotate(Vector3.FORWARD, -delta * spin_speed_fly)

var dash_target
func on_dash_point_update(point):
	dash_target = point
