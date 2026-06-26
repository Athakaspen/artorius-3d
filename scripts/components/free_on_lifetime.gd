class_name FreeOnLifetime
extends BulletComponent

@export var lifetime: float = 10 # seconds


func _process(delta: float) -> void:
	if parent_bullet.time_alive >= lifetime:
		parent.queue_free()
