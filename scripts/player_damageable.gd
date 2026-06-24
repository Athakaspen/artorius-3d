extends Node

@export var invincible_time_damage: float = 1.2
@export var invincible_time_dash: float = 0.02

var invincible_counter: float = 0
var is_invincible = false
var nohit_mode_counter: float = 0
var is_nohit_mode = false


func _process(delta: float) -> void:
	if is_invincible:
		invincible_counter -= delta
		if invincible_counter <= 0:
			is_invincible = false
			%PlayerSubtree.propagate_call("on_invincible_end")
	if is_nohit_mode:
		nohit_mode_counter -= delta
		if nohit_mode_counter <= 0:
			is_nohit_mode = false
			%PlayerSubtree.propagate_call("on_nohit_mode_end")


func start_invincible(time: float, nohit: bool):
	is_invincible = true
	invincible_counter = max(time, invincible_counter)
	%PlayerSubtree.propagate_call("on_invincible_start")
	if nohit:
		is_nohit_mode = true
		nohit_mode_counter = max(time, nohit_mode_counter)
		%PlayerSubtree.propagate_call("on_nohit_mode_start")


func take_damage() -> bool:
	if is_invincible:
		return false

	Singleton.remove_life()
	start_invincible(invincible_time_damage, true)
	return true


func on_dash_performed():
	start_invincible(invincible_time_dash, false)
