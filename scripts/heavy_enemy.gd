class_name HeavyEnemy
extends PathPauseEnemy

@export var pre_fire_duration: float = 0.5
@export var fire_duration: float = 4.2
@export var post_fire_duration: float = 0.6


func on_path_pause():
	await get_tree().create_timer(pre_fire_duration).timeout
	propagate_call(&"activate")
	await get_tree().create_timer(fire_duration).timeout
	propagate_call(&"deactivate")
	await get_tree().create_timer(post_fire_duration).timeout
	path_resume()
