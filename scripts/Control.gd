extends Control


func _ready():
	margin_right = get_viewport().get_visible_rect().size.x
	margin_bottom = get_viewport().get_visible_rect().size.y
