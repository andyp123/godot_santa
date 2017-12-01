extends Node2D

var sprite
var collected = false

func _ready():
	var area = get_node("area")
	sprite = area.get_node("sprite")
	area.connect("body_enter", self, "_on_body_enter")
	set_process(true)
	
func _process(delta):
	var world_pos = get_global_transform().get_origin()
	var pos_x = world_pos.x + sprite.get_item_rect().end.x * 0.5
	if pos_x < 0:
		queue_free()

func _on_body_enter(body):
	if collected == false:
		var anim = get_node("area/anim")
		sprite.set_frame(rand_range(4,8))
		anim.stop(true)
		anim.play("deliver")
		collected = true

