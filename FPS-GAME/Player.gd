extends KinematicBody

#export (PackedScene) var flash = null

# movement variables
var deltaT = 0.0
var gravity = 20.0
var globalFriction = 6.0
var moveSpeed = 7.0
var runAcc = 14.0
var runDeacc = 10.0
var airAcc = 2.0
var airDeacc = 2.0
var airControl = 0.3
var jumpSpeed = 8.0
var playerFriction = 0.0
var rotate_speed = 0.1
var nextJump = false
var grounded = false

# vector variables
var playerVel = Vector3.ZERO
var playerDir = Vector3.ZERO
var playerDirNorm = Vector3.ZERO

# weapon init
var damage = 100
onready var aimcast = $Head/Camera/aimCast

# sounds
var wepSnd
var jumpSnd

func _ready():
	# init resources
	# pass
	wepSnd = get_parent().get_node("wepSnd")
	jumpSnd = get_parent().get_node("jumpSnd")
	
func _process(delta):
	if Input.is_action_just_pressed("fire"):
		#_emit_flash()
		wepSnd.play()
		if aimcast.is_colliding():
			var target = aimcast.get_collider()
			if target.is_in_group("Enemy"):
				print("hit enemy")
				target.health -= damage
				

func _physics_process(delta):
	deltaT = delta
	# movement
	queueJump()
	if is_on_floor():
		groundMove()
	else:
		airMove()
	
	move_and_slide(playerVel, Vector3.UP)
	
#func _emit_flash():
	#var new_flash = flash.instance()
	#new_flash.transform = $Head/flash_spawnpoint.global_transform
	#get_node("Head/Camera").add_child(new_flash)
	
func setMove():
	Cmd._set_forwardMove(-transform.basis.z * (Input.get_action_strength("ui_up") - Input.get_action_strength("ui_down")))
	Cmd._set_rightMove(-transform.basis.x * (Input.get_action_strength("ui_left") - Input.get_action_strength("ui_right")))

func queueJump():
	nextJump = Input.is_action_pressed("jump")
		
func groundMove():
	var wishdir = Vector3.ZERO
	var wishvel = Vector3.ZERO
	
	if !nextJump:
		applyFriction(1.0)
	else:
		applyFriction(0)
		
	setMove()
	
	wishdir = Cmd.forwardmove + Cmd.rightmove
	wishdir.normalized()
	playerDirNorm = wishdir
	
	var wishspeed = wishdir.length()
	wishspeed *= moveSpeed
	
	accelerate(wishdir, wishspeed, runAcc)
	playerVel.y = 0
	
	if nextJump:
		playerVel.y = jumpSpeed
		nextJump = false
		jumpSnd.play()
	
func airMove():
	var wishdir = Vector3.ZERO
	var accel = 0.0
	
	setMove()
	wishdir = Cmd.forwardmove + Cmd.rightmove
	
	var wishspeed = wishdir.length()
	wishspeed *= moveSpeed
	
	wishdir.normalized()
	playerDirNorm = wishdir
	
	var wishspeed2 = wishspeed
	if playerVel.dot(wishdir) < 0:
		accel = airDeacc
	else:
		accel = airAcc
		
	accelerate(wishdir, wishspeed, airAcc)
	playerVel.y -= gravity * deltaT
	
func applyFriction(t : float):
	var vec : Vector3 = playerVel
	var vel : float
	var speed : float
	var newspeed : float
	var control : float
	var drop : float
	
	vec.y = 0.0
	speed = vec.length()
	drop = 0.0
	
	if is_on_floor():
		if speed < runDeacc:
			control = runDeacc
		else:
			control = speed
		drop = control * globalFriction * deltaT * t;
		
	newspeed = speed - drop
	playerFriction = newspeed
	if newspeed < 0:
		newspeed = 0
	if speed > 0:
		newspeed /= speed
		
	playerVel.x *= newspeed
	playerVel.z *= newspeed
	
func accelerate(wishdir : Vector3, wishspeed : float, accel : float):
	var addspeed : float
	var accelspeed : float
	var currentspeed : float
	
	currentspeed = playerVel.dot(wishdir)
	addspeed = wishspeed - currentspeed
	if addspeed <= 0:
		return
	accelspeed = accel * deltaT * wishspeed
	if accelspeed > addspeed:
		accelspeed = addspeed
		
	playerVel.x += accelspeed * wishdir.x
	playerVel.z += accelspeed * wishdir.z
	
func _unhandled_input(event):
	# mouse controls
	if event is InputEventMouseMotion:
		rotate_y(deg2rad(-1 * (rotate_speed * event.relative.x)))
		$Head.rotate_x(deg2rad(-1 * (rotate_speed * event.relative.y)))
		$Head.rotation.x = clamp($Head.rotation.x, deg2rad(-89), deg2rad(89))
