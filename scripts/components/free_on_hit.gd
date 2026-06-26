class_name FreeOnHit
extends SimpleComponent


func on_hit():
	parent.queue_free()
