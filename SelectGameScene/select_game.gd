extends Node2D

@onready var scroll_container = $ScrollContainer;
const SCROLL_SENSITIVITY = 0.3;
var mouse_button_down = false

func _on_scroll_container_gui_input(event):
	
	# Check whether the left mouse button is pressed...
	if (event is InputEventMouseButton):
		if (event.button_index == JOY_BUTTON_DPAD_LEFT):
			mouse_button_down = event.pressed;
	
	# Scroll with the mouse
	if (event is InputEventMouseMotion and mouse_button_down == true):
		scroll_container.scroll_vertical += event.velocity.x
	
	# Scroll with touch
	if (event is InputEventScreenDrag):
		scroll_container.scroll_vertical += event.velocity.x


func _on_button_quit_pressed():
	get_tree().quit()


func _on_button_1JumpFox_pressed():
	get_tree().change_scene_to_file("res://1_JumpFox/Level/Scene/Main/main_screen.tscn")


func _on__one_eye_fish_pressed():
	get_tree().change_scene_to_file("res://3_OneEyeFish/main_3.tscn")
