extends StaticBody2D

var opened = false
var disposto = false

func _process(delta):
	if disposto == true && Input.is_action_just_pressed("select"):
		opened = true
	if opened == true:
		$area_armario.queue_free()
		opened = false
		disposto = false
		yield(get_tree().create_timer(1),"timeout")
		$AnimatedSprite.play("open")
	





func _on_area_armario_area_entered(area):
	disposto = true
	pass # Replace with function body.


func _on_area_armario_area_exited(area):
	disposto = false
	pass # Replace with function body.
