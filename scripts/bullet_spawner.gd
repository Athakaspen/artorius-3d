extends Node3D
class_name BulletSpawner

@export var autostart : bool = true
func _ready() -> void:
	deactivate()

func activate():
	self.set_process(true)

func deactivate():
	self.set_process(false)

func on_arena_enter():
	if autostart: activate()

func on_arena_exit(): 
	deactivate()

@export var bullet_res : PackedScene
