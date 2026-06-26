class_name FreeOnDead
extends SimpleComponent


func on_dead():
	parent.queue_free()
