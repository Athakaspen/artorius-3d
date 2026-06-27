class_name BulletSpawner
extends Node3D

const shoot_sfx_res = preload("res://audio/shoot_sfx.tscn")

@export var autostart: bool = true
@export var bullet_res: PackedScene

var shoot_sfx: AudioStreamPlayer3D


func _ready() -> void:
	shoot_sfx = shoot_sfx_res.instantiate()
	add_child(shoot_sfx)
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
