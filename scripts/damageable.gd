extends Node

@onready var parent : Node3D = get_parent()

@export var max_hp : int = 100
@export var damage_cooltime : float = 0.5 # seconds

@onready var hp : int = max_hp
var cooltime_counter : float = 0.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	cooltime_counter -= delta

func on_hit(damage: int) -> bool:
	if is_invincible():
		print("hit invincible enemy: " + parent.to_string())
		return false

	hp -= damage
	cooltime_counter = damage_cooltime
	print(hp)
	parent.propagate_call("on_damage", [damage])
	
	if hp <= 0:
		if parent.has_method("on_death"):
			parent.on_death()
		else:
			parent.queue_free()
	
	return true

func is_invincible() -> bool:
	return cooltime_counter > 0
