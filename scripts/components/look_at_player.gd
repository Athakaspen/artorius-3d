class_name LookAtPlayer
extends SimpleComponent


func _process(_delta: float) -> void:
	if LevelObjects.Tim != null:
		parent.look_at(LevelObjects.Tim.position)
		parent.rotation.x = 0
		parent.rotation.z = 0
