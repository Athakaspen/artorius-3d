class_name SpeedCurveComponent
extends BulletComponent

@export var slow_speed: float = 5
@export var fast_speed: float = 10
@export var change_duration: float = 1 # seconds
@export var curve: Curve = Curve.new()

@onready var speed_range = fast_speed - slow_speed


func _physics_process(delta: float) -> void:
	var x = min(parent_bullet.time_alive / change_duration, 1)
	var y = curve.sample(x)
	parent_bullet.speed = slow_speed + y * speed_range
