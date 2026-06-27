extends AudioStreamPlayer3D


func _ready() -> void:
	play()
	connect("finished", die)


func die():
	self.queue_free()
