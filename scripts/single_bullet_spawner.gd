class_name SingleBulletSpawner
extends BulletSpawner

@export var fire_rate: float = 2 # per second
@export var initial_delay: float = 0.6
@export var bullet_speed: float = 8

@onready var fire_delay: float = 1.0 / fire_rate
@onready var cooltime_counter: float = initial_delay


func _process(delta: float) -> void:
	cooltime_counter -= delta
	if cooltime_counter <= 0:
		fire()
		cooltime_counter += fire_delay


func fire():
	var bullet = bullet_res.instantiate() as DirectionSpeedBullet
	bullet.position = global_position
	bullet.direction = -global_basis.z
	bullet.speed = bullet_speed
	LevelObjects.BulletSubtree.add_child(bullet)
	shoot_sfx.play()
