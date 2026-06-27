class_name ArcBulletSpawner
extends SingleBulletSpawner

@export var num_points: int = 6
@export var arc_angle: float = 120

@onready var rads = deg_to_rad(arc_angle)


func fire():
	for i in range(num_points):
		var bullet = bullet_res.instantiate() as DirectionSpeedBullet
		bullet.position = global_position
		var angle = (float(i) / (num_points - 1)) * rads
		bullet.direction = (-global_basis.z).rotated(Vector3.UP, angle).normalized()
		bullet.speed = bullet_speed
		LevelObjects.BulletSubtree.add_child(bullet)
	shoot_sfx.play()
