extends StaticBody2D

export var item = false
var disposto = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if disposto == true:
		if item == false:
			if get_parent().get_parent().get_node("Player").item1 == true:
				if Input.is_action_just_pressed("select"):
					yield(get_tree().create_timer(1),"timeout")
					queue_free()
		else:
			if get_parent().get_parent().get_node("Player").item4 == true:
				if Input.is_action_just_pressed("select"):
					yield(get_tree().create_timer(1),"timeout")
					queue_free()
	pass


func _on_Area2D_area_entered(area):
	disposto = true
	pass # Replace with function body.


func _on_area_porta_area_exited(area):
	disposto = false
	pass # Replace with function body.
