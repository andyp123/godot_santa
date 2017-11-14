extends Node2D

var body = null
var auto_pilot = true

var gravity_y = 30.0
var thrust_y = -30.0
var velocity = Vector2()

var min_y = 0
var max_y = 640

var thrust_penalty = 0.4
var thrust_penalty_time = 0.0

const MAX_ROTATION = 22.5
const MAX_VELOCITY_Y = 20.0

func _ready():
	body = get_node("kinematic_body")
	
	var play_area = get_parent().play_area
	min_y = play_area.pos.y
	max_y = min_y + play_area.size.y
	
	set_fixed_process(true)
	
func _fixed_process(delta):
	# set velocity and gravity
	var pos = get_pos()
	var vel_y = velocity.y
	var thrust_input = false
	
	# get input
	if Input.is_action_pressed("ctrl_thrust"):
		auto_pilot = false
		thrust_input = true
	elif auto_pilot and pos.y > 200.0:
			thrust_input = true
	
	# apply boost
	if thrust_input and thrust_penalty_time == 0.0:
		vel_y += thrust_y * delta
	else:
		vel_y += gravity_y * delta
		thrust_penalty_time -= delta
		thrust_penalty_time = clamp(thrust_penalty_time, 0.0, thrust_penalty)
			
	vel_y = clamp(vel_y, -MAX_VELOCITY_Y, MAX_VELOCITY_Y)
	velocity.y = vel_y
	pos += velocity
	
	if pos.y < min_y: # inverted y axis... grrr
		velocity.y *= -0.5
		thrust_penalty_time = thrust_penalty
	elif pos.y > max_y: # game over
		velocity.y = 0.0
	
	pos.y = clamp(pos.y, min_y, max_y)
	set_pos(pos)
	
	# set angle based on velocity
	body.set_rot(-vel_y / MAX_VELOCITY_Y * deg2rad(MAX_ROTATION))
	