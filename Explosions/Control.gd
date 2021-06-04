extends Control

var npc = ""

var wait = 0.01

export var textSpeed = 0.01
var letra = 0
var frase = 0
var todaLetra = 0
var todaFrase = 0
var end = false

var dialogos = { 
	"": [""],
	"Beholder": [
			"AAAAAA",
			"Eu não aguento mais!!!"
		],
	"Cogumelo": [
			"Merdaaaaaaaaa!!!!"
		],
	"Golem": [
			"Eae, eu sou o zelador daqui!",
			"Quer ouvir do meu rpg sobre LÁPIS?!"
		],
	"Frank": [
			"Eu sou o Frank, sou segurança aqui...",
			"Mano! Essa música é muito boa!"
	],
	"Vampira": [
			"Hmmm, essa noticia da bomba me dxou tão... empolgada!"
	],
	"Fantasma": [
			"Que?... Bomba?...",
			"Não ligo pra isso... Meu trabalho é mais importante..."
	]
		}

func _ready():
	$wait.wait_time = wait
	$Timer.wait_time = textSpeed
	pass # Replace with function body.

func _process(delta):
	if get_parent().get_parent().get_node("Player").npc != "" && end == false:
		if Input.is_action_just_pressed("select"):
			visible = true
			get_parent().get_parent().get_node("Player").talking = true
			$Nome.text = get_parent().get_parent().get_node("Player").npc
			$NomeShow.visible = true
			
			npc =  get_parent().get_parent().get_node("Player").npc
			$Portrait.play(npc)
			
	$Label.text = dialogos[npc][frase]
	$Label.visible_characters = letra
	if npc != "":
		todaFrase = dialogos[npc].size()-1
		todaLetra = dialogos[npc][frase].length()
		$Timer.start()
	
	if end == true:
		$wait.start()

func _input(event):
	if Input.is_action_just_pressed("select") && npc != "":
		
		
		
		if letra >= todaLetra:
			letra = 0
			if frase < todaFrase:
				frase+=1
			else:
				todaFrase = 0
				todaLetra = 0
				letra = 0
				frase = 0
				npc = ""
				visible = false
				get_parent().get_parent().get_node("Player").talking = false
				#print (npc)
				end = true
				return
		else:
			letra = todaLetra
	

func _on_Timer_timeout():
	if letra < todaLetra:
		letra += 1
	pass # Replace with function body.


func _on_wait_timeout():
	end = false
	pass # Replace with function body.
