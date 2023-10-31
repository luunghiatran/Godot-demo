extends Timer

var cherry = preload("res://1_JumpFox/Level/Prefab/Cherry/Cherry.tscn")
var random = RandomNumberGenerator.new()


func _on_timeout():
	# Tạo Cherry ngẫu nhiên
	var newCherry = cherry.instantiate()
	var x = random.randi_range(10, 400)	# 450 = y gần player
	newCherry.position = Vector2(x, 450)
	#get_node("Collectable").add_child(newCherry)
	add_child(newCherry)
