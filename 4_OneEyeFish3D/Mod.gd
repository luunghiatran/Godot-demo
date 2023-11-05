extends CharacterBody3D

# Minimum speed of the mob in meters per second.
@export var min_speed = 10
# Maximum speed of the mob in meters per second.
@export var max_speed = 18

signal squashed


func _physics_process(_delta):
	move_and_slide()


# called from the Main scene.
func initialize(start_position, player_position):
	# Rotate from start_position to player_position
	look_at_from_position(start_position, player_position, Vector3.UP)
	# Rotate randomly from -45 to +45 degrees,
	rotate_y(randf_range(-PI / 4, PI / 4))

	# random speed
	var random_speed = randi_range(min_speed, max_speed)
	# Veloctity by speed
	velocity = Vector3.FORWARD * random_speed
	# Rotate velocity by y
	velocity = velocity.rotated(Vector3.UP, rotation.y)

	# Random speed
	$AnimationPlayer.speed_scale = random_speed / min_speed


func _on_visible_on_screen_notifier_3d_screen_exited():
	queue_free()


func squash():
	squashed.emit()
	queue_free()
