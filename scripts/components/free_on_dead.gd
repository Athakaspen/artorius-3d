extends SimpleComponent
class_name FreeOnDead
func on_dead(): parent.queue_free()
