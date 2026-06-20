extends Node3D
class_name Knife

@export var follow_point : Node3D

var state := SPIN
enum {
	NONE,
	SPIN,
	DASH_CHARGE,
	DASH_FLY,
}

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	match state:
		SPIN, DASH_CHARGE:
			position = follow_point.global_position

func change_state(new_state):
	state = new_state
	%PlayerSubtree.propagate_call("on_knife_state_change", [state])

func on_dash_pressed():
	change_state(DASH_CHARGE)

func on_dash_released():
	change_state(DASH_FLY)

func on_dash_fly_end():
	change_state(SPIN)
