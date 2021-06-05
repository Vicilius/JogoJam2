extends KinematicBody2D

var fade
var pfade = false

const ACCELERACAO = 120
var speed = Vector2.ZERO
var slp = false
var slpng = false
var wkng = false
var walking = false
var left = false

var npc = ""
var talking = false
#pé de cabra no armario
var item1 = false
var sitem1 = false
#desentupidor no banheiro
var item2 = false
var sitem2 = false
#alicate do lado da mesa da gerente
var item3 = false
var sitem3 = false
#chave do lado da mesa do chefe
var item4 = false
var sitem4 = false

func _ready():
	$CanvasModulate.visible = true
	$Interact.wait_time = 1.5
	
	var tilemap_rect = get_parent().get_node("TileMap").get_used_rect()
	var tilemap_cell = get_parent().get_node("TileMap").cell_size
	$Camera2D.limit_left = tilemap_rect.position.x * tilemap_cell.x
	$Camera2D.limit_right = tilemap_rect.end.x * tilemap_cell.x
	$Camera2D.limit_top = tilemap_rect.position.y * tilemap_cell.y
	$Camera2D.limit_bottom = tilemap_rect.end.y * tilemap_cell.y
	fade = get_parent().get_node("Fade").get_node("AnimationPlayer")
	pass

func _physics_process(delta):
	

	
	var x = - Input.get_action_strength("ui_left") + Input.get_action_strength("ui_right")
	var y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	speed = Vector2(x, y).normalized()*ACCELERACAO
	$AnimatedSprite.flip_h = x < 0
	
	if Input.is_action_just_pressed("ui_left"):
		left = true
	elif Input.is_action_just_pressed("ui_right"):
		left = false
	
	$AnimatedSprite.flip_h = left
	
	if speed == Vector2.ZERO:
		if slp == false && walking == false:
			$AnimatedSprite.play("idle")
			$sono.start(0.017)
		else:
			if slpng == false:
				$AnimatedSprite.play("sleep")
				slpng = true
	else:
		
		if slp == true:
			if wkng == false:
				$AnimatedSprite.play("awake")
				wkng = true
				slpng = false
				$awake.start()
			if $AnimatedSprite.animation == "awake" && $AnimatedSprite.frame == 2:
				wkng = false
				slp = false
		else:
			$AnimatedSprite.play("run")
	if wkng == false && talking == false:
		move_and_slide(speed)
		
	item_collect()
	change_text()
	
	pass

func change_text():
	if npc != "":
		if Input.is_action_just_pressed("select"):
			yield(get_tree().create_timer(1),"timeout")
			npc = ""

func item_collect():
	if Input.is_action_just_pressed("select"):
		if sitem1 == true:
			sitem1 = false
			$Interact.start()
			talking = true
			fade.play("Fade")
			pfade = false
			yield(get_tree().create_timer(1),"timeout")
			item1 = true
		
		if sitem2 == true:
			sitem2 = false
			$Interact.start()
			talking = true
			fade.play("Fade")
			pfade = false
			yield(get_tree().create_timer(1),"timeout")
			item2 = true
		
		if sitem3 == true:
			sitem3 = false
			$Interact.start()
			talking = true
			fade.play("Fade")
			pfade = false
			yield(get_tree().create_timer(1),"timeout")
			item3 = true
			
		if sitem4 == true:
			sitem4 = false
			$Interact.start()
			talking = true
			fade.play("Fade")
			pfade = false
			yield(get_tree().create_timer(1),"timeout")
			item4 = true
			
		if pfade == true:
			$Interact.start()
			talking = true
			fade.play("Fade")
			pfade = false
	
	
	
func _input(event):
	if event.is_pressed():
		walking = true
	else:
		walking = false

func _on_sono_timeout():
	slp = true
	#$sono.wait_time = 0
	pass # Replace with function body.


func _on_awake_timeout():
	wkng = false
	slp = false
	pass # Replace with function body.


func _on_Area2D_area_entered(area):
	
	if area.name == "area_npc":
		npc = area.get_parent().get_node("AnimatedSprite").animation
	
	if area.get_parent().name == "interagir":
		npc = area.name
		
	if area.name == "area_armario":
		sitem1 = true
	if area.name == "area_desentupidor":
		sitem2 = true
	if area.name == "area_escrivaninha":
		if area.get_parent().chefe == true:
			sitem4 = true
		else:
			sitem3 = true
	if area.name == "area_porta":
		if area.get_parent().item == false:
			if item1 == true:
				pfade = true
			else:
				npc = "Porta"
		else:
			if item4 == true:
				pfade = true
			else:
				npc = "Porta"
	if area.name == "area_privada":
		if item2 == true:
			pfade = true
		else:
			npc = "Privada"
	if area.name == "area_bomba":
		if item3 == true:
			pfade = true
		else:
			npc = "Bomba"
	
	pass # Replace with function body.


func _on_Area2D_area_exited(area):
	if area.name == "area_npc":
		npc = ""
	if area.name == "area_armario":
		sitem1 = false
	if area.name == "area_desentupidor":
		sitem2 = false
	if area.name == "area_escrivaninha":
		if area.get_parent().chefe == true:
			sitem4 = false
		else:
			sitem3 = false
	if area.name == "area_porta":
		if area.get_parent().item == false:
			pfade = false
			npc = ""
		else:
			pfade = false
			npc = ""
	if area.name == "area_bomba":
		pfade = false
		npc = ""
		
	if area.get_parent().name == "interagir":
		npc = ""
	if area.name == "area_privada":
		pfade = false
		npc = ""
	pass # Replace with function body.


func _on_Interact_timeout():
	talking = false
	pass # Replace with function body.
