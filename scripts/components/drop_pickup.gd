class_name DropPickup
extends SimpleComponent

@export var pickup_chance: float = 1.0


func on_dead():
	var pickup: Node3D = Prefabs.HeartPickup.instantiate()
	pickup.position = parent.global_position
	LevelObjects.PickupSubtree.add_child(pickup)
