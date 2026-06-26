class_name Threat
extends Node3D

@onready var enemy = get_enemy()
@onready var path = get_path3d()


func _process(_delta: float) -> void:
	if get_enemy() == null:
		self.queue_free()


func get_enemy() -> Enemy:
	for c in get_children():
		if c is Enemy:
			return c
	return null


func get_path3d() -> Path3D:
	for c in get_children():
		if c is Path3D:
			return c
	return null
