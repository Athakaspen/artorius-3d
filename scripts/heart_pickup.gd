extends Node3D

var lifetime: float = 5.0 # seconds


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var dist = LevelObjects.LevelManager.arena_size / 2.0
	position.x = clamp(position.x, -dist, dist)
	position.z = clamp(position.z, -dist, dist)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	lifetime -= delta
	if lifetime <= 0:
		queue_free()

	var alpha = min(1.0, lifetime * 0.7)
	var color: Color = $MeshInstance3D.get_active_material(0).albedo_color
	color.a = alpha
	$MeshInstance3D.get_active_material(0).albedo_color = color


func _physics_process(_delta: float) -> void:
	for body in $Area3D.get_overlapping_bodies():
		if body is not Tim:
			print("Non-Tim picked up a heart???")
		else:
			Singleton.add_life()
			LevelObjects.ScoreManager.give_life_score()
			self.queue_free()
