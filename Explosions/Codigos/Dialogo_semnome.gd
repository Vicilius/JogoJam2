extends Control


var dialogPath = "res://Dialogo/Dialogo_1.json"
export(float) var textSpeed = 0.05

var dialog

var phraseNum = 0
var finished = false

func _ready():
	$Timer.wait_time = textSpeed
	dialog = getDialog()
	assert(dialog, "Dialog not found")
	nextPhrase()
	
	
	
func _process(delta):
	$TextureRect/AnimatedSprite.visible = finished
	
	if Input.is_action_just_pressed("ui_accept"):
		if finished:
			nextPhrase()
		else:
			$TextureRect/Label.visible_characters = len($TextureRect/Label.text)
			
	if Input.is_action_just_pressed("accept"):
		if finished:
			nextPhrase()
		else:
			$TextureRect/Label.visible_characters = len($TextureRect/Label.text)
			

func getDialog() -> Array:
	var f = File.new()
	assert(f.file_exists(dialogPath), "File Path does not exist")
	
	f.open(dialogPath, File.READ)
	var json = f.get_as_text()
	
	var output = parse_json(json)
	
	if typeof(output) == TYPE_ARRAY:
		return output
	else:
		return []
		

func nextPhrase() -> void:
	if phraseNum >= len(dialog):
		queue_free()
		return
		
	finished = false
	
	
	$TextureRect/Label.text = dialog[phraseNum]["Text"]
	
	$TextureRect/Label.visible_characters = 0
	
	
	
	#get_tree().change_scene("res://Dialogo/Dialogo_1.json")
	
	while $TextureRect/Label.visible_characters < len($TextureRect/Label.text):
		$TextureRect/Label.visible_characters += 1
		
		$Timer.start()
		yield($Timer, "timeout")
	
	finished = true
	phraseNum += 1
	return
	
