class_name PathFollowEnemy
extends PathEnemy

@export var max_speed: float = 7
@export var min_speed: float = 4
@export var speed_curve: Curve = Curve.new()

@onready var speed_range: float = max_speed - min_speed


func _process(_delta: float) -> void:
	var path_end = 1 if not mirror else 0
	if follower.progress_ratio == path_end:
		self.queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var speed = calc_speed()
	if mirror:
		speed *= -1
	follower.progress = follower.progress + speed * delta
	sync_position()


func calc_speed() -> float:
	var x = follower.progress_ratio
	if mirror:
		x = 1 - x # mirror curve sample as well
	var y = speed_curve.sample(x)
	return min_speed + y * speed_range
