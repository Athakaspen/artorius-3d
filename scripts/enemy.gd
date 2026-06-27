class_name Enemy
extends CharacterBody3D

const delete_distance_squared = 30.0 ** 2
const hit_sfx_res = preload("res://audio/hit_sfx.tscn")
const die_sfx_res = preload("res://audio/die_sfx.tscn")

@export var score_id: StringName = &"UNDEFINED ENEMY"

var hit_sfx: AudioStreamPlayer3D
var die_sfx: AudioStreamPlayer3D


func _ready() -> void:
	hit_sfx = hit_sfx_res.instantiate()
	add_child(hit_sfx)


func _process(_delta: float) -> void:
	if self.position.length_squared() >= delete_distance_squared:
		self.queue_free()


func is_invincible() -> bool:
	return defer_call_to_first_component(&"is_invincible", false)


func on_hit(damage) -> bool:
	return defer_call_to_first_component(&"on_hit", false, damage)


func on_damage(_amount: int):
	hit_sfx.play()


# defer to first component with applicable method
func defer_call_to_first_component(method: StringName, default: Variant = null, ...args) -> Variant:
	for child in get_children():
		if child is SimpleComponent and child.has_method(method):
			return child.callv(method, args)
	return default


func on_dead():
	LevelObjects.ScoreManager.give_defeat_score(score_id)
	var sfx: AudioStreamPlayer3D = die_sfx_res.instantiate()
	sfx.position = position
	LevelObjects.EnemySubtree.add_child(sfx)
