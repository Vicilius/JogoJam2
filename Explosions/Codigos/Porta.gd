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
					queue_free()
		else:
			return
	pass


func _on_Area2D_area_entered(area):
	disposto = true
	pass # Replace with function body.
