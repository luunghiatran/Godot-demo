class_name Main3
extends Node2D

@export var mob_scene: PackedScene
var score = 0


func new_game():
	print("new_game")
	
	$Player.start($StartPosition.position)
	
	score = 0
	$HUD.update_score(score)
	$HUD.hide_message()

	# Remove all mobs
	get_tree().call_group("mobs", "clear_queue")

	$Music.play()

	$MobTimer.start()
	$ScoreTimer.start()


func game_over():
	print("game_over")
	$ScoreTimer.stop()
	$MobTimer.stop()

	$HUD.show_game_over()

	$Music.stop()
	$DeathSound.stop()


func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)


func _on_mob_timer_timeout():
	# --- CREATE MOD ---
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()

	# Choose a random location on Path2D.
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.progress_ratio = randf()

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	# Set the mob's position to a random location.
	mob.position = mob_spawn_location.position

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)


func _on_player_hit():
	game_over()


func _on_hud_start_game():
	new_game()


func _on_back_pressed():
	get_tree().change_scene_to_file("res://SelectGameScene/select_game.tscn")
