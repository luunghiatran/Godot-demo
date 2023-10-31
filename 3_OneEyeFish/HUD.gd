extends CanvasLayer

# Notifies `Main` node that the button has been pressed
signal start_game


# Message in 2s
func show_message(text):
	$Message.text = text
	$Message.show()


func hide_message():
	$Message.hide()


func show_game_over():
	# --- Show Game Over
	show_message("Game Over")

	# --- Wait MessageTimer timeout (2s)
	$MessageTimer.start()
	await $MessageTimer.timeout

	# --- Show Title 
	show_message("Dodge the Creeps!")

	# --- show Start after 1s
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()


func update_score(score):
	$ScoreLabel.text = str(score)


func _on_start_button_pressed():
	$StartButton.hide()
	start_game.emit()
