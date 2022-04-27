extends Spatial

export (PackedScene) var enemy

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	randomize()
	
func _process(delta):
	if Input.is_action_just_pressed("quit"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().quit()


func _on_enemyTimer_timeout():
	if EnemyCounter.count < 8:
		# instantiate new enemy instance called mob
		var mob = enemy.instance()
		# choose random location on path to spawn, and give it random offset
		var enemy_spawn_location = get_node("spawn/spawnLoc")
		enemy_spawn_location.unit_offset = randf()
		# get player position
		var player_position = $Player.transform.origin
		add_child(mob)
		mob.initialize(enemy_spawn_location.translation, player_position)
		EnemyCounter._spawned()
	else:
		pass
