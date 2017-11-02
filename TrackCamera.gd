extends Camera2D

export(float) var min_y = -800.0
export(float) var max_y = 0.0

var target = null
export(Vector2) var target_offset = Vector2()

func _ready():
	set_process(true)
	
	target = get_parent().get_node("player")
#	target_offset.y = Globals.get("display/height") * 0.5

func _process(delta):
	var pos = get_pos()
	var pos_y = pos.y
	
	if target != null:
		pos_y = target.get_pos().y - target_offset.y
	
	pos_y = clamp(pos_y, min_y, max_y)
	print(pos_y)
	pos.y = pos_y
	set_pos(pos)