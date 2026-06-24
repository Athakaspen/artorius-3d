extends Node3D

@export var bullet_res: PackedScene
@export var num_bullets: int = 8

var p1: Vector3 = Vector3(-14, 0, -12)
var p2: Vector3 = Vector3(-14, 0, 12)


func _ready() -> void:
	var diff = p2 - p1
	for i in range(num_bullets):
		var point = p1 + diff * (float(i) / (num_bullets - 1))
		point.y = 0
		var bullet = bullet_res.instantiate() as DirectionSpeedBullet
		bullet.position = point
		bullet.direction = Vector3.RIGHT
		add_child(bullet)


func _process(_delta: float) -> void:
	if get_child_count() == 0:
		self.queue_free()
