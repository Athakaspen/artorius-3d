extends Node

var god_mode : bool = false
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_god_mode"):
		god_mode = !god_mode

var player_lives : int = 3
signal lost_life(remaining: int)
func remove_life():
	player_lives -= 1
	lost_life.emit(player_lives)
signal gained_life(remaining: int)
func add_life():
	player_lives += 1
	gained_life.emit(player_lives)
