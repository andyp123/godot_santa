extends Camera2D

export(int, -420) var min_y
export(int, 0) var max_y
export(float, 10.0) var tracking_speed

var target = null
var velocity = Vector2()

func _ready():
	set_process(true)
	
	parent = get_parent()
	target = parent.get_node("player")

func _process(delta):
	if target != null:
		pass
	
	var pos = get_pos()
	pos.y = clamp(pos.y, min_y, max_y)
	set_pos(pos)