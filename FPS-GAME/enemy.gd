extends KinematicBody

export var min_speed = 12
export var max_speed = 18
var velocity = Vector3.ZERO
var health = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
 
func _process(delta):
	if health <= 0:
		EnemyCounter._killed()
		queue_free()

func _physics_process(delta):
	var player_position = get_node("../Player").get_translation()
	look_at(player_position, Vector3.UP)
	move_and_slide((player_position - get_translation()).normalized() * velocity)
	move_and_slide(get_transform()[2] * delta * velocity)
	
func initialize(start_position, player_position):
	translation = start_position
	look_at(player_position, Vector3.UP)
	rotate_y(rand_range(-PI / 4, PI / 4))
	var random_speed = rand_range(min_speed, max_speed)
	velocity = Vector3.FORWARD * random_speed
	velocity = velocity.rotated(Vector3.UP, rotation.y)
