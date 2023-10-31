extends Area2D

# @onready var Game = preload("res://1_JumpFox/Code/Script/Global/Game.gd")
# @onready var Util = preload("res://1_JumpFox/Code/Script/Global/Util.gd").new()


func _on_body_entered(body):
	if body.name == "Player":
		Game.gold += 2
		
		# Fly up animation
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", position - Vector2(0, 30), 0.3)
		
		# Fade out
		var tween1 = get_tree().create_tween()
		tween1.tween_property(self, "modulate:a", 0, 0.2)
		
		# remove self after finish tween
		tween.tween_callback(queue_free)
		# queue_free()
		
