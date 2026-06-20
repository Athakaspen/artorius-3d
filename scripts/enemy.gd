extends CharacterBody3D
class_name Enemy

@export var pickup_chance : float = 1.0

func on_dead():
	var pickup : Node3D = Prefabs.HeartPickup.instantiate()
	pickup.position = global_position
	%PickupSubtree.add_child(pickup)
	
	self.queue_free()
