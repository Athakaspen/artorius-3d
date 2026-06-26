extends HBoxContainer

@export var heart: PackedScene


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Singleton.connect("lost_life", on_lost_life)
	Singleton.connect("gained_life", on_gained_life)

	await get_tree().process_frame

	for n in get_children():
		n.queue_free()
	for i in range(Singleton.player_lives):
		add_child(heart.instantiate())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func on_lost_life(remaining: int):
	if get_child_count() > 0:
		get_child(0).queue_free()


func on_gained_life(remaining: int):
	while get_child_count() < remaining:
		add_child(heart.instantiate())
