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

var item1 = false
var sitem1 = false

func _ready():
	
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
	pass

func item_collect():
	if Input.is_action_just_pressed("select"):
		if sitem1 == true:
			sitem1 = false
			item1 = true
			pfade = true
			
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
	
	if area.name == "area_armario":
		sitem1 = true
	if area.name == "area_porta":
		if area.get_parent().item == false:
			if item1 == true:
				pfade = true
	
	pass # Replace with function body.


func _on_Area2D_area_exited(area):
	if area.name == "area_npc":
		npc = ""
	if area.name == "area_armario":
		sitem1 = false
	pass # Replace with function body.


func _on_Interact_timeout():
	talking = false
	pass # Replace with function body.
