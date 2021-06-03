extends Node2D

func _process(delta):
	if(get_parent().get_node("Player").position.x -192 >= get_parent().get_node("Player").get_node("Camera2D").limit_left
	&& get_parent().get_node("Player").position.x +192 <= get_parent().get_node("Player").get_node("Camera2D").limit_right):
		position.x = get_parent().get_node("Player").position.x - 192
	
	if(get_parent().get_node("Player").position.y -108 >= get_parent().get_node("Player").get_node("Camera2D").limit_top
	&& get_parent().get_node("Player").position.y +108 <= get_parent().get_node("Player").get_node("Camera2D").limit_bottom) :
		position.y = get_parent().get_node("Player").position.y - 108
