extends Node

var DirectionVectors : Dictionary[StringName, Vector3] = {
	&"dir_up": Vector3.FORWARD,
	&"dir_down": Vector3.BACK,
	&"dir_left": Vector3.LEFT,
	&"dir_right": Vector3.RIGHT,
	&"dir_up_left": (Vector3.FORWARD + Vector3.LEFT).normalized(),
	&"dir_up_right": (Vector3.FORWARD + Vector3.RIGHT).normalized(),
	&"dir_down_left": (Vector3.BACK + Vector3.LEFT).normalized(),
	&"dir_down_right": (Vector3.BACK + Vector3.RIGHT).normalized(),
}

func get_vector(dir: StringName) -> Vector3:
	return DirectionVectors[dir]

func dir_away(side: StringName) -> StringName:
	match side:
		&"side_top": return &"dir_down"
		&"side_bottom": return &"dir_up"
		&"side_left": return &"dir_right"
		&"side_right": return &"dir_left"
	print ("Unexpected side in dir_away")
	return &"dir_down"

func random_vector_flat() -> Vector3:
	return Vector3(randf()-0.5, 0, randf()-0.5)
