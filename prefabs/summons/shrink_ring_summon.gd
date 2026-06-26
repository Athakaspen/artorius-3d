extends Node3D

@export var tim: Tim
@export var follow_time: float = 2.0 # seconds
@export var bullet_res: PackedScene
@export var radius: float = 3
@export var num_bullets: int = 12

var is_following = true


func _ready() -> void:
	self.global_position = tim.global_position
	for i in range(num_bullets):
		var angle = (2 * PI / num_bullets) * i
		var pos = Vector3.FORWARD * radius
		var point = pos.rotated(Vector3.UP, angle)
		point.y = 0
		var bullet = bullet_res.instantiate() as DirectionSpeedBullet
		bullet.position = point
		bullet.direction = -point.normalized()
		add_child(bullet)


func _process(delta: float) -> void:
	if get_child_count() == 0:
		LevelObjects.ScoreManager.give_defeat_score(&"shrink_ring")
		self.queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if is_following:
		self.global_position = tim.global_position
		follow_time -= delta
		if follow_time <= 0:
			is_following = false
			propagate_call(&"start_bullet", [delta])
