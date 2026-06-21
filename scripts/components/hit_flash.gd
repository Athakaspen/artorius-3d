extends SimpleComponent
class_name HitFlash

@export var flash_dur : float = 0.15 # seconds
@export var mesh : MeshInstance3D
@export var material : ShaderMaterial = preload("uid://husbjvdyujmi")

var active : bool = false
var counter : float = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not active: return
	counter -= delta
	if counter < 0:
		deactivate()

func on_damage(damage: int) -> void:
	active = true
	counter = flash_dur
	mesh.material_overlay = material

func deactivate() -> void:
	active = false
	mesh.material_overlay = null
