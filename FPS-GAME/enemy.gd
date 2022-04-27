extends KinematicBody

export var min_speed = 12
export var max_speed = 18
var velocity = Vector3.ZERO
var health = 200

func _ready():
	pass
	
func _process(delta):
	if health <= 0:
		EnemyCounter._killed()
		queue_free()

func _physics_process(delta):
	if EnemyCounter.playerAlive:
		var player_position = get_node("../Player").get_translation()
		look_at(player_position, Vector3.UP)
		var dir_to_target = (player_position - get_translation()).normalized()
		move_and_slide(dir_to_target * velocity)

	
func initialize(start_position, player_position):
	translation = start_position
	look_at(player_position, Vector3.UP)
	var random_speed = rand_range(min_speed, max_speed)
	velocity = Vector3.FORWARD * random_speed
	velocity = velocity.rotated(Vector3.UP, rotation.y)
