extends Node2D

export(float) var scroll_speed = 200
export(bool) var debug = false

var play_area = Rect2()
var background

func _enter_tree():
	background = get_node("background")
	
	var sky_height = 700
	play_area.pos = Vector2(0, -sky_height)
	play_area.size = Vector2(Globals.get("display/width"), Globals.get("display/height") + sky_height)
	
	set_process(true)
	
func _process(delta):
	update_background(delta)
	
func _draw():
	if debug:
		draw_set_transform(Vector2(), 0, Vector2(1, 1))
		draw_rect(play_area, Color(0, 1, 0, 0.5))
	
func update_background(delta):
	if background == null:
		return
	
	var offset = background.get_scroll_base_offset()
	offset.x -= scroll_speed * delta
	background.set_scroll_base_offset(offset)
	
	
