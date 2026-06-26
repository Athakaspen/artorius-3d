class_name ScoreManager
extends Node

signal score_change(new_value: int, delta: int)

const base_points: Dictionary[StringName, int] = {
	&"none": 0,
	&"apple": 10,
	&"burger": 15,
	&"taco": 25,
	&"fries": 15,
	&"shrink_ring": 5,
	&"line": 5,
	&"cake": 100,
}

var cur_score = 0


func give_defeat_score(type: StringName):
	if type not in base_points:
		printerr("Unknown type! " + type)
	else:
		add_score(base_points[type])


func give_life_score():
	add_score(Singleton.player_lives * 5)


func add_score(amount: int):
	if not Singleton.is_alive:
		return
	cur_score += amount
	score_change.emit(cur_score, amount)
	Singleton.update_score(cur_score)
