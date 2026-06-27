extends Enemy

enum {
	INTRO,
	STATIONARY_FIRE,
	PATH_FIRE,
	CIRCLE_START,
	CIRCLE_FOLLOW,
	Z_START,
	Z_FOLLOW,
	REST,
}

@export var intro_speed_curve: Curve
@export var stationary_fire_dur: float = 3.5
@export var circle_fire_dur: float = 5.0
@export var circle_speed: float = 10.0
@export var after_circle_pause: float = 2
@export var z_speed: float = 14.0
@export var after_z_pause: float = 3

var state := INTRO
var intro_follow: PathFollow3D
var circle_follow: PathFollow3D
var z_follow: PathFollow3D


func _ready() -> void:
	super()
	intro_follow = _create_path_follow($"../StraightPath")
	circle_follow = _create_path_follow($"../CirclePath")
	circle_follow.loop = true
	z_follow = _create_path_follow($"../ZPath")
	global_position = intro_follow.position


func _physics_process(delta: float) -> void:
	match state:
		INTRO:
			intro_follow.progress += delta * intro_speed_curve.sample(intro_follow.progress_ratio)
			sync_position(intro_follow)
			if intro_follow.progress_ratio >= 0.5:
				rest(0.5, STATIONARY_FIRE)
		CIRCLE_FOLLOW:
			circle_follow.progress += delta * circle_speed
			sync_position(circle_follow)
		Z_FOLLOW:
			z_follow.progress += delta * z_speed
			sync_position(z_follow)
			if (z_follow.progress_ratio == 1):
				$ZSpawner.deactivate()
				rest(after_z_pause, STATIONARY_FIRE)


func sync_position(follow: PathFollow3D):
	global_position = follow.global_position


func change_state(new_state: Variant):
	match new_state:
		STATIONARY_FIRE:
			$StationarySpawner.activate()
			await get_tree().create_timer(stationary_fire_dur).timeout
			$StationarySpawner.deactivate()
			rest(0.5, PATH_FIRE)
		PATH_FIRE:
			if randf() > 0.5:
				change_state(CIRCLE_START)
			else:
				change_state(Z_START)
		CIRCLE_START:
			var start = ($"../CirclePath".curve as Curve3D).get_closest_offset(global_position)
			circle_follow.progress_ratio = start
			var tween = create_tween()
			tween.tween_property(self, "position", circle_follow.global_position, 0.8)
			await tween.finished
			await get_tree().create_timer(0.2).timeout
			state = CIRCLE_FOLLOW
			$CircleSpawner.activate()
			await get_tree().create_timer(circle_fire_dur).timeout
			$CircleSpawner.deactivate()
			rest(after_circle_pause, STATIONARY_FIRE)
		Z_START:
			z_follow.progress_ratio = 0
			var tween = create_tween()
			tween.tween_property(self, "position", z_follow.global_position, 0.8)
			await tween.finished
			await get_tree().create_timer(0.2).timeout
			state = Z_FOLLOW
			$ZSpawner.activate()


func rest(dur: float, next: Variant):
	state = REST
	await get_tree().create_timer(dur).timeout
	change_state(next)


func on_dead():
	super()
	LevelObjects.LevelManager.on_boss_dead()


func _create_path_follow(path: Path3D):
	var follow := PathFollow3D.new()
	follow.loop = false
	path.add_child(follow)
	return follow
