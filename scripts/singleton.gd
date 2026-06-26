extends Node

signal lost_life(remaining: int)
signal gained_life(remaining: int)
signal player_died()
signal high_score_change(new: int)

var player_lives: int = 1
var is_alive: bool = true
var high_score: int = 0
var tutorial_done := false


func remove_life():
	player_lives -= 1
	lost_life.emit(player_lives)
	if player_lives < 0:
		is_alive = false
		player_died.emit()


func add_life():
	player_lives += 1
	gained_life.emit(player_lives)


func set_lives(num: int):
	player_lives = num
	gained_life.emit(player_lives)


func update_score(score: int):
	if score > high_score:
		high_score = score
		high_score_change.emit(high_score)
