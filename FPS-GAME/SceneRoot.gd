extends Spatial

export (PackedScene) var enemy

var enemy_spawn_location

func _ready():
	$userInterface/Retry.hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	randomize()
	
func _process(delta):
	if Input.is_action_just_pressed("quit"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		get_tree().quit()

func _on_enemyTimer_timeout():
	if EnemyCounter.playerAlive:
		if EnemyCounter.count < 8:
			# instantiate new enemy instance called mob
			var mob = enemy.instance()
			# choose random location on path to spawn, and give it random offset
			var loc = randi()
			if loc == 1:
				enemy_spawn_location = get_node("spawn/spawnLoc")
			else:
				enemy_spawn_location = get_node("spawn/spawnLoc2")
			# get player position
			var player_position = $Player.transform.origin
			add_child(mob)
			mob.initialize(enemy_spawn_location.translation, player_position)
			EnemyCounter._spawned()
	else:
		pass

func _on_Player_player_dead():
		print("player dead")
		$userInterface/Retry.show()

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept") and $userInterface/Retry.visible:
		EnemyCounter.count = 0
		get_tree().reload_current_scene()
