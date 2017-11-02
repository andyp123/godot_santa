extends ParallaxBackground


export var scroll_speed = 200.0

func _ready():
	set_process(true)

func _process(delta):
	var offset = get_scroll_base_offset()
	offset.x -= scroll_speed * delta
	set_scroll_base_offset(offset)
