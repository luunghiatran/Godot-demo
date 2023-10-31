extends Label

# @onready var Game = preload("res://1_JumpFox/Code/Script/Global/Game.gd")
# @onready var Util = preload("res://1_JumpFox/Code/Script/Global/Util.gd").new()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#text = "HP: " + str(get_node("../../Player/Player").health)
	text = "HP: " + str(Game.playerHP)
