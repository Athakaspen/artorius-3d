extends Node

@export var flash_dur : float = 0.08 # seconds
@export var mesh : MeshInstance3D
@export var damageable : Node
@export var material : ShaderMaterial
@onready var parent: Node3D = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

var active : bool = false
var counter : float = 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not damageable.is_invincible(): deactivate()
	if not active: return
	
	counter += delta
	if counter > 0: counter = -flash_dur
	if counter < 0:
		mesh.material_overlay = material
	else:
		mesh.material_overlay = null

func on_damage(damage: int) -> void:
	active = true
	counter = -flash_dur

func deactivate() -> void:
	active = false
	mesh.material_overlay = null
