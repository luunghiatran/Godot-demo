extends Node

@onready var Util = preload("res://1_JumpFox/Code/Script/Global/Util.gd").new()
@onready var Game = preload("res://1_JumpFox/Code/Script/Global/Game.gd")

# Called when the node enters the scene tree for the first time.
func _ready():
	Util.load_game()
	
	# Reset save data
	if Game.playerHP == 0:
		Game.playerHP = 3


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_quit_pressed():
	get_tree().quit()


func _on_play_pressed():
	get_tree().change_scene_to_file("res://1_JumpFox/Level/Scene/Playing/playing_screen.tscn")
	#get_tree().change_scene_to_file("res://1_JumpFox/Level/Prefab/Frog/test_fog.tscn")


func _on_back_pressed():
	get_tree().change_scene_to_file("res://SelectGameScene/select_game.tscn")
