extends Camera2D

export(float) var min_y = -800.0
export(float) var max_y = 0.0
export(float) var track_time = 0.25

var target = null
export(Vector2) var target_offset = Vector2()

func _ready():
	set_process(true)
	
	var parent = get_parent()
	target = parent.get_node("player")
	if target != null:
		target_offset.x = target.get_pos().x
	else:
		print("could not find '%s/player'" % parent.get_path())

func _process(delta):
	if target != null:
		var pos = get_pos()
		var target_pos = target.get_pos() - target_offset
		var ofs = target_pos - pos
		var distance = ofs.length()
		if distance > 0:
			var speed = distance / track_time
			pos += (ofs / distance) * speed * delta
			pos.y = clamp(pos.y, min_y, max_y)
			set_pos(pos)
