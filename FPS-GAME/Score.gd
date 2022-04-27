extends Label

var score = 0

func _on_Player_hit_enemy():
	score += 1
	text = "Score: %s" % score
