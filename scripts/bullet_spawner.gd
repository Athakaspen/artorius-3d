class_name BulletSpawner
extends Node3D

@export var autostart: bool = true
@export var bullet_res: PackedScene


func _ready() -> void:
	deactivate()


func activate():
	self.set_process(true)


func deactivate():
	self.set_process(false)


func on_arena_enter():
	if autostart:
		activate()


func on_arena_exit():
	deactivate()
