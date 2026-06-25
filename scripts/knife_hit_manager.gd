extends Node

@export var damage_normal: int = 15
@export var damage_focus: int = 25
@export var damage_fly: int = 50
@export var hit_cooltime_normal: float = 0.15
@export var hit_cooltime_focus: float = 0.1
@export var hit_cooltime_fly: float = 0.08
@export var hitbox: Area3D

var cooltime_counter: float = 0

@onready var knife: Knife = get_parent()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	cooltime_counter -= delta

	# no hits while invincible
	if %PlayerDamageable.is_nohit_mode:
		return
	# no hits while charging dash
	if knife.state == Knife.DASH_CHARGE:
		return

	if cooltime_counter <= 0:
		var is_focusing = %Tim.is_focusing

		var damage = damage_focus if is_focusing else damage_normal
		if knife.state == Knife.DASH_FLY:
			damage = damage_fly

		var overlap = hitbox.get_overlapping_bodies()
		var hit_anything := false
		for body in overlap:
			if body is Enemy:
				var success: bool = body.on_hit(damage)
				if success:
					hit_anything = true
			else:
				print("Knife hit non-enemy body!!!" + body.to_string())

		if hit_anything:
			var cooltime = hit_cooltime_focus if is_focusing else hit_cooltime_normal
			if knife.state == Knife.DASH_FLY:
				cooltime = hit_cooltime_fly
			cooltime_counter = cooltime
