class_name PathEnemy
extends Enemy

@export var init_path: Path3D
@export var mirror: bool = false
@export var face_forward: bool = false
@export var offset: Vector3 = Vector3.ZERO

var follower: PathFollow3D


func _ready() -> void:
	super()
	if init_path != null:
		set_path(init_path)
	sync_position()


func _process(_delta: float) -> void:
	if follower.progress_ratio == 0 or follower.progress_ratio == 1:
		self.queue_free()


func set_path(path: Path3D):
	follower = PathFollow3D.new()
	follower.loop = false
	path.add_child(follower)
	follower.progress_ratio = 0.001 if not mirror else 0.999


func sync_position() -> void:
	global_position = follower.global_position + offset
	if face_forward:
		global_rotation = follower.global_rotation
