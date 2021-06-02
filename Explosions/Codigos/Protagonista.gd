extends KinematicBody2D

const ACCELERACAO = 120
var speed = Vector2.ZERO
var slp = false
var slpng = false
var wkng = false
var walking = false
var left = false

func _ready():
	
	var tilemap_rect = get_parent().get_node("TileMap").get_used_rect()
	var tilemap_cell = get_parent().get_node("TileMap").cell_size
	$Camera2D.limit_left = tilemap_rect.position.x * tilemap_cell.x
	$Camera2D.limit_right = tilemap_rect.end.x * tilemap_cell.x
	$Camera2D.limit_top = tilemap_rect.position.y * tilemap_cell.y
	$Camera2D.limit_bottom = tilemap_rect.end.y * tilemap_cell.y
	
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
	if wkng == false:
		move_and_slide(speed)
	pass

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
