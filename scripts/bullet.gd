extends Node3D
class_name Bullet

@export var collider : Area3D
func ready():
	if not collider.get_collision_layer_value(2):
		print ("bullet has sus collision")

const delete_distance_squared = 30.0**2

var time_alive : float = 0
func _process(delta: float) -> void:
	time_alive += delta

func _physics_process(delta: float) -> void:
	if position.length_squared() > delete_distance_squared:
		self.queue_free()

	var overlap = collider.get_overlapping_bodies()
	if overlap.size() > 0:
		var hit_success := false
		for body in overlap:
			if body is not Tim:
				print("Bullet hit something other than Tim???" + body.to_string())
			else:
				if (body as Tim).take_damage() == true: 
					hit_success = true
		if hit_success: propagate_call("on_hit")
