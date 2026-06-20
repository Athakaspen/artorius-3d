extends Node3D

@export var bullet : PackedScene
@export var fire_rate : float = 3 # per second
@onready var fire_delay : float = 1.0 / fire_rate
@export var bullet_speed : float = 7

var cooltime_counter : float = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.rotate(Vector3.UP, -delta * 0.2)
	cooltime_counter -= delta
	if cooltime_counter <= 0:
		fire()
		cooltime_counter += fire_delay

func fire():
	for child in get_children():
		var direction = (child.global_position - global_position).normalized()
		var bullet = bullet.instantiate() as Bullet
		bullet.position = global_position
		bullet.velocity = direction * bullet_speed
		%BulletSubtree.add_child(bullet)

func fire_count(count: int):
	for i in range(count):
		fire()
		await get_tree().create_timer(0.1).timeout
