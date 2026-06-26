extends Sprite3D

var speed: float = 3


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	self.position += Vector3.BACK * delta * speed
	if self.position.z > 28:
		self.queue_free()
