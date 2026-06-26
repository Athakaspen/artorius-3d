class_name Enemy
extends CharacterBody3D

const delete_distance_squared = 30.0 ** 2

@export var score_id: StringName = &"UNDEFINED ENEMY"


func _process(delta: float) -> void:
	if self.position.length_squared() >= delete_distance_squared:
		self.queue_free()


func is_invincible() -> bool:
	return defer_call_to_first_component(&"is_invincible", false)


func on_hit(damage) -> bool:
	return defer_call_to_first_component(&"on_hit", false, damage)


# defer to first component with applicable method
func defer_call_to_first_component(method: StringName, default: Variant = null, ...args) -> Variant:
	for child in get_children():
		if child is SimpleComponent and child.has_method(method):
			return child.callv(method, args)
	return default


func on_dead():
	LevelObjects.ScoreManager.give_defeat_score(score_id)
