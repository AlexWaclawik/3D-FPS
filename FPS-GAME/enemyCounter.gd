extends Node

var count = 0
var playerAlive = true

func _ready():
	pass

func _killed():
	count -= 1
	
func _spawned():
	count += 1
