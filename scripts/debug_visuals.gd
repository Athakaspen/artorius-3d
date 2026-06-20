extends Node

@onready var tim: CharacterBody3D = %Tim
@onready var knife: Node3D = %Knife
@export var dash_charge: Node
@export var mesh: MeshInstance3D

var material

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	material = mesh.get_active_material(0) as StandardMaterial3D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if tim.is_invincible():
		material.albedo_color = Color.BLACK
	elif dash_charge.active:
		var amt = dash_charge.charge_amount
		material.albedo_color = Color(0.7-amt*0.7, 1.0, 0.7-amt*0.7)
	else:
		if tim.is_focusing:
			material.albedo_color = Color.RED
		else:
			material.albedo_color = Color.WHITE
	
	if knife.state == Knife.DASH_CHARGE:
		$Flymarker.visible = true
		var mesh : ImmediateMesh = $Flymarker.mesh
		mesh.clear_surfaces()
		mesh.surface_begin(Mesh.PRIMITIVE_LINES, material)
		mesh.surface_add_vertex(knife.global_position)
		mesh.surface_add_vertex($"../../Knife/VisualManager".aim_point)
		mesh.surface_end()

func on_mouse_move(point):
	$MouseMarker.global_position = point

func on_dash_point_update(point):
	$DashMarker.visible = true
	$DashMarker.global_position = point

func on_dash_released():
	$DashMarker.visible = false

func on_dash_fly_end():
	$Flymarker.visible = false
