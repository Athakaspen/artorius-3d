extends Node3D

var spinning : bool = true

const disable = false

var speed_normal = 5.0
var speed_focus = 1.7

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !spinning or disable: return
	
	if %Tim.is_focusing:
		rotate(Vector3.UP, -delta * speed_focus)
	else:
		rotate(Vector3.UP, -delta * speed_normal)

func on_knife_state_change(state):
	if state == Knife.SPIN:
		spinning = true
	else:
		spinning = false
