extends Node3D

const disable = false

var spinning: bool = true
var speed_normal = 5.0
var speed_focus = 1.7
var dist_normal = 1.8
var dist_focus = 2.4


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !spinning or disable:
		return

	if %Tim.is_focusing:
		rotate(Vector3.UP, -delta * speed_focus)
		create_tween().tween_property($KnifeFollowPoint, "position", Vector3.RIGHT * dist_focus, 0.1)
	else:
		rotate(Vector3.UP, -delta * speed_normal)
		create_tween().tween_property($KnifeFollowPoint, "position", Vector3.RIGHT * dist_normal, 0.1)


func on_knife_state_change(state):
	if state == Knife.SPIN:
		spinning = true
	else:
		spinning = false
