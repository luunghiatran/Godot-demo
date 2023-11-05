extends Node3D

@export var mob_scene: PackedScene

func _ready():
	# Hide Retry message
	$UserInterface/Retry.hide()

func _on_mob_timer_timeout():
	# ---- Spawn Mob -----
	# Create new Mob
	var mob = mob_scene.instantiate()

	# random location on SpawnPath
	var mob_spawn_location = get_node("SpawnPath/SpawnLocation")
	# random offset.
	mob_spawn_location.progress_ratio = randf()

	var player_position = $Player.position
	mob.initialize(mob_spawn_location.position, player_position)

	add_child(mob)

	# ----- Mod squash
	# when receive mob squashed signal, ScoreLabel call function _on_mob_squashed().
	mob.squashed.connect($UserInterface/ScoreLabel._on_mob_squashed.bind())

func _on_player_hit():
	$MobTimer.stop()
	$UserInterface/Retry.show()

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept") and $UserInterface/Retry.visible:
		# restarts scene.
		get_tree().reload_current_scene()


func _on_back_pressed():
	get_tree().change_scene_to_file("res://SelectGameScene/select_game.tscn")
