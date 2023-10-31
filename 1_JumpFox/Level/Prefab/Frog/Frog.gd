# class_name Frog
extends CharacterBody2D

var SPEED = 50

# @onready var Game = preload("res://1_JumpFox/Code/Script/Global/Game.gd")
@onready var Util = preload("res://1_JumpFox/Code/Script/Global/Util.gd")
@onready var animSprite = $AnimatedSprite2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player: Player
var chase = false

func _on_ready():
	animSprite.play("Idle")

func _physics_process(delta):
	
	# Gravity
	velocity.y += gravity * delta
	
	if animSprite.animation == "Death":
		return

	if chase:
		player = get_node("../../Player/Player")
		player = player if player else get_node("../Player/Player")
		var direction = (player.position - self.position).normalized()
		
		# Move
		velocity.x = direction.x * SPEED
		
		if direction.x > 0:
			# print("Right")
			animSprite.flip_h = true	
		else:
			# print("Left")
			animSprite.flip_h = false
		animSprite.play("Jump")

	else:
		velocity.x = 0
		animSprite.play("Idle")

	move_and_slide()

func _on_player_detection_body_entered(body):
	# print(body.name) // Name Collition
	
	# Go to near "Player"
	if body.name == "Player":
		chase = true


func _on_player_detection_body_exited(body:Node2D):
	# Go to far "Player"
	if body.name == "Player":
		chase = false


func _on_death_zone_body_entered(body):
	if animSprite.animation == "Death":
		return
	
	if body.name == "Player":
		Game.gold += 1
		Util.save_game()
		death()

func _on_player_collision_body_entered(body):
	if animSprite.animation == "Death":
		return
	
	if body.name == "Player":
		Game.playerHP -= 1
		Util.save_game()
		death()

func death():
	chase = false
	animSprite.play("Death")
	await animSprite.animation_finished
	self.queue_free() # remove object
