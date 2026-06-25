class_name HitFlash
extends SimpleComponent

@export var flash_dur: float = 0.06 # seconds
@export var visual: Node3D
@export var material: Material

var active: bool = false
var counter: float = 0.0


func _ready() -> void:
	if visual == null:
		visual = parent


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not active:
		return
	counter -= delta
	if counter < 0:
		deactivate()


func on_damage(_damage: int) -> void:
	active = true
	counter = flash_dur
	apply_material_to_subtree(visual, material)


func deactivate() -> void:
	active = false
	apply_material_to_subtree(visual, null)


func apply_material_to_subtree(node: Node, mat: Material) -> void:
	if node is MeshInstance3D:
		node.material_overlay = mat

	for child in node.get_children():
		apply_material_to_subtree(child, mat)
