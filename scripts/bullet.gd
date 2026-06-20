extends Node3D
class_name Bullet

const delete_distance_squared = 30.0**2

var velocity : Vector3 = Vector3.ZERO

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position += velocity * delta
	if position.length_squared() > delete_distance_squared:
		self.queue_free()

func _physics_process(delta: float) -> void:
	var overlap = $Area3D.get_overlapping_bodies()
	if overlap.size() > 0:
		for body in overlap:
			if body is not Tim:
				print("Bullet hit something otherthan Tim???" + body.to_string())
			else:
				(body as Tim).take_damage()
		self.queue_free()
