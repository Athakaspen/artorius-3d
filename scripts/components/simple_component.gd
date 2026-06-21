extends Node
class_name SimpleComponent

@onready var parent: Node = get_parent()

func get_component(type: Variant):
	for child in parent.get_children():
		if is_instance_of(child, type):
			return child
	return null
