extends Node2D

var selection = 0

func _input(event):
	if Input.is_action_just_pressed("ui_down"):
		selection += 1
		if selection > 1:
			selection = 0
	elif Input.is_action_just_pressed("ui_up"):
		selection -= 1
		if selection < 0:
			selection = 1
	if Input.is_action_just_pressed("select"):
		$Marcador/Confirma.visible = true
		print(selection)
		if selection == 0:
			yield(get_tree().create_timer(0.1),"timeout")
			get_tree().change_scene("res://Cenas/Level/MainLevel .tscn")

func _process(delta):
	if selection == 0:
		$Marcador.position = Vector2(149,164)
	else:
		$Marcador.position = Vector2(149,194)

