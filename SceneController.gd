extends Node2D

# scene controller:
# - game speed (background scroll, obstacle movement speed)
# - player sensitivity (adjust gravity and boost scale)
# - obstacle spawning
# - game over, restart

const BACKGROUND_SCROLL_SCALE = 0.7

export(float) var scroll_speed = 300.0
export(bool) var debug = false

var play_area = Rect2()
var background
var foreground

func _enter_tree():
	background = get_node("background")
	foreground = get_node("foreground")
	
	var sky_height = 700
	play_area.pos = Vector2(0, -sky_height)
	play_area.size = Vector2(Globals.get("display/width"), Globals.get("display/height") + sky_height)
	
	set_process(true)
	
func _process(delta):
	update_background(delta)
	update_foreground(delta)
	
func _draw():
	if debug:
		draw_set_transform(Vector2(), 0, Vector2(1, 1))
		draw_rect(play_area, Color(0, 1, 0, 0.5))

func update_foreground(delta):
	if foreground != null:
 		foreground.update_obstacles(scroll_speed * delta)

func update_background(delta):
	if background != null:
		var offset = background.get_scroll_base_offset()
		offset.x -= scroll_speed * BACKGROUND_SCROLL_SCALE * delta
		background.set_scroll_base_offset(offset)
	
	
