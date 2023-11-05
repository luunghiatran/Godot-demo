class_name Player4
extends CharacterBody3D

# Move Speed
@export var speed = 14
# Fall down speed
@export var fall_acceleration = 75

signal hit

var target_velocity = Vector3.ZERO

@export var jump_impulse = 20	# Jump height
@export var bounce_impulse = 16 # Jump far (meters per second)

# _process
# _physics_process: runs at fixed time intervals as much as possible 
# to keep the physics interactions stable 
func _physics_process(delta):

	# ----- Press key -> Move -----
	# input direction.
	var direction = Vector3.ZERO

	# input -> update the direction
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_back"):
		# Notice how we are working with the vector's x and z axes.
		# In 3D, the XZ plane is the ground plane.
		direction.z += 1
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1

		
	# Player had Input
	if direction != Vector3.ZERO:
		direction = direction.normalized() # convert 1.4 -> 1, keep direction is stable in one Input
		$Pivot.look_at(position + direction, Vector3.UP)	# rotate object to position (compare with position before)

		$AnimationPlayer.speed_scale = 4	# jump animation x 4 (jump height x4)
	else:
		$AnimationPlayer.speed_scale = 1	# jump animation normal


	# Ground Velocity
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed

	# Vertical Velocity
	if not is_on_floor(): # If in the air, fall towards the floor. Literally gravity
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)


	# Jumping.
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		target_velocity.y = jump_impulse


	# collisions occurred this frame
	for index in range(get_slide_collision_count()):
		var collision = get_slide_collision(index)

		# If the collision is with ground
		if collision.get_collider() == null:
			continue

		# collider with mob
		if collision.get_collider().is_in_group("mob"):
			var mob = collision.get_collider()
			# from above.
			if Vector3.UP.dot(collision.get_normal()) > 0.1:
				# squash it and bounce.
				mob.squash()
				target_velocity.y = bounce_impulse

	# Moving the Character
	velocity = target_velocity
	move_and_slide()

	$Pivot.rotation.x = PI / 6 * velocity.y / jump_impulse	# character arc on top animation

func _on_mob_detector_body_entered(_body:Node3D):
	die()

func die():
	hit.emit()
	queue_free()
