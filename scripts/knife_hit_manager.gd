extends Node

@export var damage_normal : int = 15
@export var damage_focus : int = 25
@export var damage_fly : int = 40
@export var hit_cooltime_normal : float = 0.7
@export var hit_cooltime_focus : float = 0.4
@export var hitbox : Area3D

@onready var knife : Knife = get_parent()

var cooltime_counter : float = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	cooltime_counter -= delta
	
	if cooltime_counter <= 0 and knife.state != Knife.DASH_CHARGE:
		var is_focusing = %Tim.is_focusing
		
		var damage = damage_focus if is_focusing else damage_normal
		if knife.state == Knife.DASH_FLY: damage = damage_fly
		
		var overlap = hitbox.get_overlapping_bodies()
		for body in overlap:
			if body.has_node("Damageable"):
				var success : bool = body.get_node("Damageable").on_hit(damage)
				if success:
					cooltime_counter = hit_cooltime_focus if is_focusing else hit_cooltime_normal
			else:
				print("Knife hit non-damageable body!!!")
