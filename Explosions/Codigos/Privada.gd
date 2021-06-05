extends StaticBody2D

export var item = false
var disposto = false

const BombaRes = preload("res://Cenas/Instance/Bomba.tscn")
var Bomba

# Called when the node enters the scene tree for the first time.
func _ready():
	Bomba = BombaRes.instance()
	Bomba.name = "Bomba"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if disposto == true:
			if get_parent().get_parent().get_node("Player").item2 == true:
				if Input.is_action_just_pressed("select"):
					$area_privada.queue_free()
					yield(get_tree().create_timer(1),"timeout")
					get_parent().add_child(Bomba)
					get_parent().get_node("Bomba").position = position
	pass


func _on_area_privada_area_entered(area):
	disposto = true
	pass # Replace with function body.


func _on_area_privada_area_exited(area):
	disposto = false
	pass # Replace with function body.
