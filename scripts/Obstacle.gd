extends Node2D

var sprite

func _ready():
	sprite = get_node("obstacle/sprite")
	
func get_rect_ws():
	var pos = sprite.get_global_transform().get_origin()
	return Rect2(pos, sprite.get_item_rect().size) 
