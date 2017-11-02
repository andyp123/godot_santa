extends Node2D

var gravity_y = 30.0
var thrust_y = -30.0
var velocity = Vector2()

const MAX_ROTATION = 22.5
const MAX_VELOCITY_Y = 20.0

var body = null

func _ready():
	body = get_node("kinematic_body")
	set_fixed_process(true)
	
func _fixed_process(delta):
	# set velocity and gravity
	var vel_y = velocity.y
	if Input.is_action_pressed("ctrl_thrust"):
		vel_y += thrust_y * delta
	else:
		vel_y += gravity_y * delta
	vel_y = clamp(vel_y, -MAX_VELOCITY_Y, MAX_VELOCITY_Y)
	velocity.y = vel_y
	
	var pos = get_pos()
	pos += velocity
	set_pos(pos)
	
	# set angle based on velocity
	body.set_rot(-vel_y / MAX_VELOCITY_Y * deg2rad(MAX_ROTATION))
	