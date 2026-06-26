class_name Tim
extends CharacterBody3D

@export var normal_speed = 10.0
@export var focus_speed: float = 6.0
@export var dash_charge_speed: float = 1.6

var is_focusing: bool = false

@onready var player_subtree = %PlayerSubtree
@onready var player_damageable = $PlayerDamageable


func _ready() -> void:
	Singleton.connect("player_died", _on_player_died)


func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	var cur_speed = normal_speed if !is_focusing else focus_speed
	if $States/DashCharge.active:
		cur_speed = dash_charge_speed
		$SophiaSkin.fall()

	if direction:
		velocity.x = direction.x * cur_speed
		velocity.z = direction.z * cur_speed
		# Calculate angle. Add PI because Godot 3D models typically face -Z by default
		var target_angle = atan2(velocity.x, velocity.z)

		# Smoothly rotate the visual node
		$SophiaSkin.rotation.y = lerp_angle($SophiaSkin.rotation.y, target_angle, delta * 12)
		if !is_focusing and !$States/DashCharge.active:
			$SophiaSkin.move()
	else:
		velocity.x = 0
		velocity.z = 0
		if !is_focusing and !$States/DashCharge.active:
			$SophiaSkin.idle()
	move_and_slide()

	if abs(global_position.x) > LevelObjects.LevelManager.arena_size / 2:
		global_position = Vector3.UP
	if abs(global_position.z) > LevelObjects.LevelManager.arena_size / 2:
		global_position = Vector3.UP


func _input(event):
	if event.is_action_pressed("focus"):
		is_focusing = true
		player_subtree.propagate_call("on_focus_change", [true])
		$SophiaSkin.jump()

	elif event.is_action_released("focus"):
		is_focusing = false
		player_subtree.propagate_call("on_focus_change", [false])
		$SophiaSkin.idle()

	if event.is_action_pressed("dash"):
		player_subtree.propagate_call("on_dash_pressed")
	elif event.is_action_released("dash"):
		player_subtree.propagate_call("on_dash_released")

	if event is InputEventMouseMotion:
		# Get the point that the mouse intersect's Tim's XZ plane
		var camera3d = get_viewport().get_camera_3d()
		var origin = camera3d.project_ray_origin(event.position)
		var direction = camera3d.project_ray_normal(event.position)
		var length = -(origin.y - position.y) / direction.y
		var point = origin + direction * length
		player_subtree.propagate_call("on_mouse_move", [point])


func take_damage() -> bool:
	return player_damageable.take_damage()


func is_invincible():
	return player_damageable.is_invincible


func _on_player_died():
	LevelObjects.DeathPanel.show_lose()
	$"../../CameraManager/ThirdPersonCam".process_mode = Node.PROCESS_MODE_DISABLED
	$"../../CameraManager/ThirdPersonCam2".process_mode = Node.PROCESS_MODE_DISABLED
	$"../../LevelManager/AnimationPlayer".pause()
	self.queue_free()
	%Knife.queue_free()
