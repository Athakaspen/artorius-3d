class_name LevelManager
extends Node

enum {
	TUTORIAL,
	ANIM_LEVEL,
	BOSS,
	USER_MENU,
	ENDLESS,
}

var arena_center := Vector3.ZERO
var arena_size: float = 20 # width/height
var spawn_margin: float = 5 # how far outside area to spawn enemies
var state = TUTORIAL


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# draw the arena size for debug
	var mesh: ImmediateMesh = $ArenaBoundaryMesh.mesh
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
func _process(_delta: float) -> void:
	pass


func end_tutorial():
	Singleton.tutorial_done = true
	if state == TUTORIAL:
		state = ANIM_LEVEL
		$AnimationPlayer.play("level1")
	else:
		printerr("LEVEL MAANGER BAD TUTORIAL END")


func on_boss_dead():
	if state == BOSS:
		state = USER_MENU
		LevelObjects.WinPanel.show_win()
	else:
		printerr("LEVEL MAANGER BAD BOSS DED")


func on_start_endless():
	if state == USER_MENU:
		state = ENDLESS
		LevelObjects.WinPanel.visible = false
		print("TODO: implement endless mode")
	else:
		printerr("LEVEL MAANGER BAD USER MENU")


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == &"level1" and state == ANIM_LEVEL:
		state = BOSS
	else:
		printerr("LEVEL MAANGER BAD ANIM END")
