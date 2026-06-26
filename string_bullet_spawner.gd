extends SingleBulletSpawner

@export var num_bullets: int = 8
@export var speed_curve: Curve


func fire():
	for i in range(num_bullets):
		var bullet = bullet_res.instantiate() as DirectionSpeedBullet
		bullet.position = global_position
		bullet.direction = global_basis.x.normalized()
		bullet.speed = speed_curve.sample(float(i) / num_bullets)
		LevelObjects.BulletSubtree.add_child(bullet)
