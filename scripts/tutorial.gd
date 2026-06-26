extends Node

enum {
	MOVE,
	FOCUS,
	DASH,
	GOODLUCK,
}

var state = MOVE


func _ready() -> void:
	await get_tree().process_frame
	if Singleton.tutorial_done:
		LevelObjects.LevelManager.end_tutorial()
		self.queue_free()


func on_burger_dead():
	$Focus.queue_free()
	state = DASH
	$Dash.visible = true
	$Dash/StaticBody3D.position.y = 1


func _on_move_area_body_entered(body: Node3D) -> void:
	if body is not Tim:
		print("Non-tim doing tutorial move???")
	else:
		$Move.queue_free()
		state = FOCUS
		$Focus.visible = true
		$Focus/Burger.position.y = 0.8


func _on_dash_area_body_entered(body: Node3D) -> void:
	if body is not Tim:
		print("Non-tim doing tutorial dash???")
	elif state != DASH:
		return
	else:
		$Dash.queue_free()
		state = GOODLUCK
		$GoodLuck.visible = true
		await get_tree().create_timer(2.5).timeout
		LevelObjects.LevelManager.end_tutorial()
		self.queue_free()
