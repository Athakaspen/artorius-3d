extends SingleBulletSpawner
class_name RingBulletSpawner

@export var num_points : int = 6

func fire():
	for i in range(num_points):
		var bullet = bullet_res.instantiate() as DirectionSpeedBullet
		bullet.position = global_position
		var angle = 2 * PI * (float(i) / num_points)
		bullet.direction = (-basis.z).rotated(Vector3.UP, angle).normalized()
		bullet.speed = bullet_speed
		LevelObjects.BulletSubtree.add_child(bullet)
