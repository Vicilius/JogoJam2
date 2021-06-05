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
	],
	"Lapis": [
			"*ENCARA*"
	],
	"Porta": [
			"Está trancada!"
	],
	"Privada":[
			"Precisa desentupir.",
			"Talvez eu encontre um desentupidor em algum lugar..."
	],
	"Bomba": [
			"Não acredito... Está mesmo aqui!!",
			"Preciso de alguma coisa para desarmar ela!",
			"Talvez um alicate..."
	],
	"Placa1": [
			"Área dos funcionários"
	],
	"Placa2": [
			"Escritórios"
	],
	"Placa3": [
			"Sala do chefe"
	],
	"Estátua": [
			"Uma empresa de lápis com uma estátua de lápis?",
			"Esse pesoal deve levar o trabalho muito a sério."
	], 
	"Banco": [
			"Sério que eles tem que trabalhar nesses bancos de madeira?",
			"Parece bem desconfortável."
	],
	"Cadeira": [
			"Parece que pelo menos alguém aqui senta em um lugar confortável..."
	],
	"Caixa": [
			"Me pergunto o que teria nessas caixas...",
			"Melhor não pensar muito nisso."
	],
	"Estante": [
			"Uma estante na sala dos funcionários?!",
			"E tudo aqui são cadernos?!",
			"O que ta acontecendo nessa empresa??"
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
				visible = false
				npc = ""
				get_parent().get_parent().get_node("Player").talking = false
				#print (npc)
				$Portrait.play(".")
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
