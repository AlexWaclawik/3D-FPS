extends Label

var health = 500

func _on_Player_hit_player():
	health -= 100
	text = "Health: %s" % health
