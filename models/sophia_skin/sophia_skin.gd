class_name SophiaSkin
extends Node3D

@export var blink = true:
	set = set_blink

var run_tilt = 0.0:
	set = _set_run_tilt

@onready var animation_tree = %AnimationTree
@onready var state_machine: AnimationNodeStateMachinePlayback = animation_tree.get("parameters/StateMachine/playback")
@onready var move_tilt_path: String = "parameters/StateMachine/Move/tilt/add_amount"
@onready var blink_timer = %BlinkTimer
@onready var closed_eyes_timer = %ClosedEyesTimer
@onready var eye_mat = $sophia/rig/Skeleton3D/Sophia.get("surface_material_override/2")


func _ready():
	blink_timer.connect(
		"timeout",
		func():
			eye_mat.set("uv1_offset", Vector3(0.0, 0.5, 0.0))
			closed_eyes_timer.start(0.2)
	)

	closed_eyes_timer.connect(
		"timeout",
		func():
			eye_mat.set("uv1_offset", Vector3.ZERO)
			blink_timer.start(randf_range(1.0, 4.0))
	)


func set_blink(state: bool):
	if blink == state:
		return
	blink = state
	if blink:
		blink_timer.start(0.2)
	else:
		blink_timer.stop()
		closed_eyes_timer.stop()


func idle():
	state_machine.travel("Idle")
	create_tween().tween_property($sophia, "position", Vector3.BACK * 0, 0.1)


func move():
	state_machine.travel("Move")
	create_tween().tween_property($sophia, "position", Vector3.BACK * 0, 0.1)


func fall():
	state_machine.travel("Fall")
	create_tween().tween_property($sophia, "position", Vector3.FORWARD * 0.05, 0.1)


func jump():
	state_machine.travel("Jump")
	create_tween().tween_property($sophia, "position", Vector3.BACK * 0.25, 0.1)


func edge_grab():
	state_machine.travel("EdgeGrab")
	create_tween().tween_property($sophia, "position", Vector3.BACK * 0, 0.1)


func wall_slide():
	state_machine.travel("WallSlide")
	create_tween().tween_property($sophia, "position", Vector3.BACK * 0, 0.1)


func _set_run_tilt(value: float):
	run_tilt = clamp(value, -1.0, 1.0)
	animation_tree.set(move_tilt_path, run_tilt)
