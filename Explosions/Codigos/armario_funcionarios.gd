extends StaticBody2D

var opened = false
var disposto = false

func _process(delta):
	if disposto == true && Input.is_action_just_pressed("select"):
		opened = true
	if opened == true:
		$AnimatedSprite.play("open")
		$area_armario.queue_free()
		opened = false
		disposto = false
	





func _on_area_armario_area_entered(area):
	disposto = true
	pass # Replace with function body.


func _on_area_armario_area_exited(area):
	disposto = false
	pass # Replace with function body.
