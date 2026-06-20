extends Node

@export var invincible_time : float = 1.0

var invincible_counter : float = 0
var is_invincible = false

func take_damage() -> bool:
	if is_invincible: return false
	
	Singleton.remove_life()
	is_invincible = true
	invincible_counter = invincible_time
	%PlayerSubtree.propagate_call("on_invincible_start")
	return true

func _process(delta: float) -> void:
	if is_invincible:
		invincible_counter -= delta
		if invincible_counter <= 0:
			is_invincible = false
			%PlayerSubtree.propagate_call("on_invincible_end")
