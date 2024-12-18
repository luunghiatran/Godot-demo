class_name Player1
extends CharacterBody2D

# @onready var Game = preload("res://1_JumpFox/Code/Script/Global/Game.gd")

const SPEED = 110.0
const JUMP_VELOCITY = -300.0

# Khởi tạo sau khi OnReady
# @onready var anim = get_node("AnimatedSprite2D")
@onready var animSprite = $AnimatedSprite2D
@onready var anim = $AnimationPlayer

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# NẾU KHÔNG ĐỨNG YÊN -> THÊM TRỌng lực
	if not is_on_floor():
		velocity.y += gravity * delta
		
	# Nhấn Enter & Đứng yên -> thêm vận tốc vào Y
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if velocity.y < 0:
		anim.play("Jump")
	if velocity.y > 0:
		anim.play("Fall")

	# Nhấn trái, phải
	var input_axis = Input.get_axis("ui_left", "ui_right")
	if input_axis:
		# thêm vận tốc vào X
		velocity.x = input_axis * SPEED
		
		# Xoay hình dựa vào Trục
		animSprite.flip_h = input_axis < 0
		
		if velocity.y == 0:
			anim.play("Run")

	else:
		# Vận tốc giảm từ X về 0 (trong 1 khoảng SPEED)
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0:
			anim.play("Idle")
			
	# Death, back to Main
	if Game.playerHP <= 0:
		anim.play("Death")
		get_tree().change_scene_to_file("res://1_JumpFox/Level/Scene/Main/main_screen.tscn")

	move_and_slide()	# Di chuyển Body dựa vào Velocity (vận tốc)
