extends Node

@export var dash_charge: Node
@export var tim_mesh: MeshInstance3D
@export var knife_mesh: MeshInstance3D

var tim_material: StandardMaterial3D
var knife_material: StandardMaterial3D

@onready var tim: CharacterBody3D = %Tim
@onready var knife: Node3D = %Knife


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#tim_material = tim_mesh.get_active_material(0)
	#knife_material = knife_mesh.get_active_material(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#if tim.is_invincible():
	#tim_material.albedo_color = Color.BLACK
	#elif dash_charge.active:
	#var amt = dash_charge.charge_amount
	#tim_material.albedo_color = Color(0.7 - amt * 0.7, 1.0, 0.7 - amt * 0.7)
	#else:
	#if tim.is_focusing:
	#tim_material.albedo_color = Color.BLUE
	#else:
	#tim_material.albedo_color = Color.WHITE

	#if %PlayerDamageable.is_nohit_mode:
	#knife_material.albedo_color = Color.BLACK
	#else:
	#knife_material.albedo_color = Color.WHITE

	if knife.state == Knife.DASH_CHARGE:
		$FlyMarker.visible = true
		var mesh: ImmediateMesh = $FlyMarker.mesh
		mesh.clear_surfaces()
		mesh.surface_begin(Mesh.PRIMITIVE_LINES, tim_material)
		mesh.surface_add_vertex(knife.global_position)
		mesh.surface_add_vertex($"../../Knife/VisualManager".aim_point)
		mesh.surface_end()


func on_mouse_move(point):
	$MouseMarker.global_position = point


func on_dash_fly_end():
	$FlyMarker.visible = false
