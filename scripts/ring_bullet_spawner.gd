class_name RingBulletSpawner
extends SingleBulletSpawner

@export var num_points: int = 6


func fire():
	for i in range(num_points):
		var bullet = bullet_res.instantiate() as DirectionSpeedBullet
		bullet.position = global_position
		var angle = (float(i) / num_points) * 2 * PI
		bullet.direction = (-basis.z).rotated(Vector3.UP, angle).normalized()
		bullet.speed = bullet_speed
		LevelObjects.BulletSubtree.add_child(bullet)
