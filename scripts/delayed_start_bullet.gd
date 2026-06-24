class_name DelayedStartBullet
extends DirectionSpeedBullet

var is_started: bool = false


func _physics_process(delta: float) -> void:
	if is_started:
		position += direction * speed * delta
		super(delta)


func start_bullet(delta):
	time_alive = 0
	is_started = true
	$SpeedCurveComponent._physics_process(delta)
