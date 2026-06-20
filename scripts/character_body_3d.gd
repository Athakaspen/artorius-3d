extends CharacterBody3D
class_name Tim

@onready var player_subtree = %PlayerSubtree
@onready var player_damageable = $PlayerDamageable

@export var normal_speed = 12.0
@export var focus_speed : float = 5.0
@export var dash_charge_speed : float = 1.1
var is_focusing : bool = false

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	var cur_speed = normal_speed if !is_focusing else focus_speed
	if $States/DashCharge.active: cur_speed = dash_charge_speed
	
	if direction:
		velocity.x = direction.x * cur_speed
		velocity.z = direction.z * cur_speed
	else:
		velocity.x = move_toward(velocity.x, 0, focus_speed)
		velocity.z = move_toward(velocity.z, 0, focus_speed)

	move_and_slide()


func _input(event):
	if event.is_action_pressed("focus"):
		is_focusing = true
		player_subtree.propagate_call("on_focus_change", [true])
		
	elif event.is_action_released("focus"):
		is_focusing = false
		player_subtree.propagate_call("on_focus_change", [false])
	
	if event.is_action_pressed("dash"):
		player_subtree.propagate_call("on_dash_pressed")
	elif event.is_action_released("dash"):
		player_subtree.propagate_call("on_dash_released")
	
	if event is InputEventMouseMotion:
		# Get the point that the mouse intersect's Tim's XZ plane
		var camera3d = get_viewport().get_camera_3d()
		var origin = camera3d.project_ray_origin(event.position)
		var direction = camera3d.project_ray_normal(event.position)
		var len = -(origin.y - position.y) / direction.y
		var point = origin + direction * len
		player_subtree.propagate_call("on_mouse_move", [point])

func take_damage() -> bool: return player_damageable.take_damage()
func is_invincible(): return player_damageable.is_invincible
