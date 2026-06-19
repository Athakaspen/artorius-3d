extends CharacterBody3D


const SPEED = 11.0
const JUMP_VELOCITY = 5.5


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("dash") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	var cur_speed
	if Input.is_action_pressed("focus"):
		cur_speed = SPEED * 0.5
		(($MeshInstance3D as MeshInstance3D).get_active_material(0) as StandardMaterial3D).albedo_color = Color.RED
	else:
		cur_speed = SPEED
		(($MeshInstance3D as MeshInstance3D).get_active_material(0) as StandardMaterial3D).albedo_color = Color.WHITE
	
	if direction:
		velocity.x = direction.x * cur_speed
		velocity.z = direction.z * cur_speed
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
