extends Node
class_name LevelManager

var arena_center := Vector3.ZERO
var arena_size : float = 20 # width/height
var spawn_margin : float = 5 # how far outside area to spawn enemies

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# draw the arena size for debug
	var mesh : ImmediateMesh = $ArenaBoundaryMesh.mesh
	mesh.clear_surfaces()
	mesh.surface_begin(Mesh.PRIMITIVE_LINE_STRIP)
	var height = 0.2
	var offset = arena_size / 2
	mesh.surface_add_vertex(arena_center + Vector3(offset, height, offset))
	mesh.surface_add_vertex(arena_center + Vector3(offset, height, -offset))
	mesh.surface_add_vertex(arena_center + Vector3(-offset, height, -offset))
	mesh.surface_add_vertex(arena_center + Vector3(-offset, height, offset))
	mesh.surface_add_vertex(arena_center + Vector3(offset, height, offset))
	var offset_outside = offset + spawn_margin
	mesh.surface_add_vertex(arena_center + Vector3(offset_outside, height, offset_outside))
	mesh.surface_add_vertex(arena_center + Vector3(offset_outside, height, -offset_outside))
	mesh.surface_add_vertex(arena_center + Vector3(-offset_outside, height, -offset_outside))
	mesh.surface_add_vertex(arena_center + Vector3(-offset_outside, height, offset_outside))
	mesh.surface_add_vertex(arena_center + Vector3(offset_outside, height, offset_outside))
	mesh.surface_end()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func get_point_on_side(side: StringName, offset: float, mirror: bool = false) -> Vector3:
	var dist = arena_size / 2
	var p1
	var p2
	var margin
	match side:
		&"side_top":
			p1 = arena_center + Vector3(-dist, 0, -dist)
			p2 = arena_center + Vector3(dist, 0, -dist)
			margin = Vector3.FORWARD * spawn_margin
		&"side_bottom":
			p1 = arena_center + Vector3(-dist, 0, dist)
			p2 = arena_center + Vector3(dist, 0, dist)
			margin = Vector3.BACK * spawn_margin
		&"side_left":
			p1 = arena_center + Vector3(-dist, 0, -dist)
			p2 = arena_center + Vector3(-dist, 0, dist)
			margin = Vector3.LEFT * spawn_margin
		&"side_right":
			p1 = arena_center + Vector3(dist, 0, -dist)
			p2 = arena_center + Vector3(dist, 0, dist)
			margin = Vector3.RIGHT * spawn_margin
		_:
			print(side)
	var from = p1 if not mirror else p2
	var to = p2 if not mirror else p1
	var diff = to - from
	return from + diff * offset + margin

func spawn_sentry(side: StringName) -> void:
	var start_side : StringName
	var mirror : bool = false
	match side:
		&"side_top": 
			start_side = &"side_left"
		&"side_bottom": 
			start_side = &"side_left"
			mirror = true
		&"side_left": 
			start_side = &"side_top"
		&"side_right": 
			start_side = &"side_top"
			mirror = true
	var spawn_pos : Vector3 = get_point_on_side(start_side, 0.15, mirror)
	var move_dir : StringName = Globals.dir_away(start_side)
	
	var sentry = Prefabs.Sentry.instantiate() as Enemy
	sentry.position = spawn_pos
	sentry.move_dir = Globals.get_vector(move_dir)
	%EnemySubtree.add_child(sentry)
