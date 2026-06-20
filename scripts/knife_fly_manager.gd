extends Node

@export var speed : float = 30

@onready var knife : Knife = get_parent()

var active : bool = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not active: return
	
	var difference = knife.follow_point.global_position - knife.global_position
	var direction = difference.normalized()
	var offset = direction * speed * delta
	if offset.length_squared() > difference.length_squared():
		knife.global_translate(difference)
		active = false
		%PlayerSubtree.propagate_call("on_dash_fly_end")
	else:
		knife.global_translate(offset)

func on_knife_state_change(state):
	if state == Knife.DASH_FLY:
		active = true
