extends Node

const burger_threat_res = preload("uid://4lm10a5i4ijw")
const fries_threat_res = preload("uid://bgji888tubelb")
const taco_threat_res = preload("uid://dkkvx2wa1o71q")
const cake_threat_res = preload("uid://btyu5m80rh7wt")
const apple_threat_res = preload("uid://bawn7e2nrlahm")

var ring_res = preload("res://prefabs/summons/shrink_ring_summon.tscn")
var line_res = preload("res://prefabs/summons/line_summon.tscn")

@onready var level_manager = %LevelManager


func swoop(offset: Vector3 = Vector3.ZERO, rotate: float = 0):
	var enemy = burger_threat_res.instantiate()
	enemy.position = offset
	enemy.rotate(Vector3.UP, deg_to_rad(rotate))
	%EnemySubtree.add_child(enemy)


func swoop_loop():
	for i in range(4):
		swoop(Vector3.ZERO, -i * 90)
		await get_tree().create_timer(1.4).timeout


func swoop_group(count: int = 3, rotate: float = 0):
	var offset = Vector3.ZERO
	for i in range(count):
		swoop(offset, rotate)
		offset += Vector3.BACK * 1.1
		await get_tree().create_timer(0.5).timeout


func apple(offset := 0.0, side := 0):
	var apple_threat: Threat = apple_threat_res.instantiate()
	apple_threat.position += (Vector3.FORWARD * offset).rotated(Vector3.UP, -(PI / 2) * side)
	apple_threat.rotate(Vector3.UP, -(PI / 2) * side)
	LevelObjects.EnemySubtree.add_child(apple_threat)


func fries(offset := 0.0, side := 0, mirror := false):
	var fries_threat: Threat = fries_threat_res.instantiate()
	fries_threat.position += (Vector3.FORWARD * offset).rotated(Vector3.UP, -(PI / 2) * side)
	fries_threat.rotate(Vector3.UP, -(PI / 2) * side)
	fries_threat.get_enemy().mirror = mirror
	LevelObjects.EnemySubtree.add_child(fries_threat)


func taco(offset := Vector3.ZERO, rotate := 0.0):
	var taco_threat: Threat = taco_threat_res.instantiate()
	taco_threat.position += offset
	taco_threat.rotate(Vector3.UP, deg_to_rad(rotate))
	LevelObjects.EnemySubtree.add_child(taco_threat)


func cake(side := 0):
	var cake_threat: Threat = cake_threat_res.instantiate()
	cake_threat.rotate(Vector3.UP, -(PI / 2) * side)
	LevelObjects.EnemySubtree.add_child(cake_threat)


func ring_summon():
	var ring = ring_res.instantiate()
	ring.tim = LevelObjects.Tim
	LevelObjects.BulletSubtree.add_child(ring)


func line_summon():
	var line = line_res.instantiate()
	line.p1 += Vector3(randf_range(-2, 2), 0, randf_range(-2, 2))
	line.p2 += Vector3(randf_range(-2, 2), 0, randf_range(-2, 2))
	line.num_bullets += randi_range(-6, 3)
	line.position.y = 1
	line.rotate(Vector3.UP, -(PI / 2) * randi_range(0, 3))
	LevelObjects.BulletSubtree.add_child(line)
