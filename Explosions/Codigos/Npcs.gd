extends StaticBody2D


export var f = true
var fliped = false

export var npc = ""


# Called when the node enters the scene tree for the first time.
func _ready():
	fliped = f
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$AnimatedSprite.play(npc)
	$AnimatedSprite.flip_h = fliped
	pass


func _on_area_personagem_area_entered(area):
	fliped = position.x - area.get_parent().position.x > 0
	pass # Replace with function body.




func _on_area_personagem_area_exited(area):
	fliped = f
	pass # Replace with function body.
