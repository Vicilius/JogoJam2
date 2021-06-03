extends Area2D


func _on_Area2D_area_entered(area):
	$Sprite.visible = true
	$AnimationPlayer.play("Idle")
	
	pass # Replace with function body.


func _on_Area2D_area_exited(area):
	$Sprite.visible = false
	pass # Replace with function body.
