class_name EnemyDamageable
extends SimpleComponent

@export var max_hp: int = 40
@export var damage_cooltime: float = 0.01 # seconds

var cooltime_counter: float = 0.0

@onready var hp: int = max_hp


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	cooltime_counter -= delta


func on_hit(damage: int) -> bool:
	if is_invincible():
		return false

	hp -= damage
	cooltime_counter = damage_cooltime
	print(hp)
	parent.propagate_call(&"on_damage", [damage])

	if hp <= 0:
		parent.propagate_call(&"on_dead")

	return true


func is_invincible() -> bool:
	return cooltime_counter > 0
