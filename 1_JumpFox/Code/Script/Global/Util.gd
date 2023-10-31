class_name Util

extends Node

# @onready var Game = preload("res://1_JumpFox/Code/Script/Global/Game.gd")

const SAVE_PATH = "res://savegame.bin"
const KEY_PLAYER_HP = "playerHP"
const KEY_GOLD = "gold"

static func save_game():
	var hp = Game.playerHP if Game.playerHP != null else 0
	var gold = Game.gold if Game.gold != null else 0
	
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	var data: Dictionary = {
		KEY_PLAYER_HP: hp,
		KEY_GOLD: gold
	}
	var dataStr = JSON.stringify(data)	# Convert Dictionary to String
	file.store_line(dataStr)
	
static func load_game():
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file != null:
		if file.file_exists(SAVE_PATH) == true:
			# Reading Cusor end of file
			if not file.eof_reached():
				var currentLine = JSON.parse_string(file.get_line())
				if currentLine:
					Game.playerHP = currentLine[KEY_PLAYER_HP]
					Game.gold = currentLine[KEY_GOLD]
