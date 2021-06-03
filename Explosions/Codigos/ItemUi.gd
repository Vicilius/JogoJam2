extends Control

onready var player = get_parent().get_node("Player")

var minutes = 0
var seconds = 0

func _ready():
	$Timer.set_wait_time(5*60)
	$Timer.start()


func _process(delta):
	
	if(get_parent().get_node("Player").position.x -192 >= get_parent().get_node("Player").get_node("Camera2D").limit_left
	&& get_parent().get_node("Player").position.x +192 <= get_parent().get_node("Player").get_node("Camera2D").limit_right):
		margin_left = get_parent().get_node("Player").position.x - 190
	
	if(get_parent().get_node("Player").position.y -108 >= get_parent().get_node("Player").get_node("Camera2D").limit_top
	&& get_parent().get_node("Player").position.y +108 <= get_parent().get_node("Player").get_node("Camera2D").limit_bottom) :
		margin_top = get_parent().get_node("Player").position.y - 100
		
	if player.item1 == true:
		$Item1.visible = true
	show_timer()

func show_timer():
	minutes = stepify($Timer.time_left/60, 0.01)
	
	$TimerShow/Label.set_text(str(minutes))

func _on_Timer_timeout():
	print("GAME OVER")
	pass # Replace with function body.
