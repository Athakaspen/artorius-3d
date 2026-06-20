extends Node3D

var lifetime : float = 5.0 # seconds

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	lifetime -= delta
	if lifetime <= 0:
		queue_free()
	
	var alpha = min(1.0, lifetime * 0.7)
	var color : Color = $MeshInstance3D.get_active_material(0).albedo_color
	color.a = alpha
	$MeshInstance3D.get_active_material(0).albedo_color = color


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is not Tim:
		print("Non-Tim picked up a heart???")
	else:
		Singleton.add_life()
		self.queue_free()
