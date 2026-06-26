class_name PathPauseEnemy
extends PathEnemy

@export var stop_dist: float = 0.5
@export var max_speed: float = 7
@export var min_speed: float = 4
@export var speed_curve: Curve = Curve.new()

var paused: bool = false
var has_paused: bool = false

@onready var speed_range: float = max_speed - min_speed


func _process(_delta: float) -> void:
	var path_end = 1 if not mirror else 0
	if follower.progress_ratio == path_end:
		self.queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if paused:
		return

	var speed = calc_speed()
	if mirror:
		speed *= -1
	follower.progress = follower.progress + speed * delta
	sync_position()

	if has_paused:
		return
	var progress_m = follower.progress_ratio
	if mirror:
		progress_m = 1 - progress_m
	if progress_m > stop_dist:
		paused = true
		has_paused = true
		propagate_call(&"on_path_pause")


func path_resume():
	paused = false
	mirror = !mirror


func calc_speed() -> float:
	var x = follower.progress_ratio
	if mirror:
		x = 1 - x # mirror curve sample as well
	if !has_paused:
		x = x / stop_dist
	else:
		x = 1 - (x - stop_dist) / (1 - stop_dist)
	var y = speed_curve.sample(x)
	return min_speed + y * speed_range
