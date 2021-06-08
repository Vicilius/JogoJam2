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
			"Uma bomba, não é possível!",
			"É meu ultimo més trabalhando aqui e eles resolvem meter uma BOMBA!"
		],
	"Cogumelo": [
			"Uma bomba?",
			"Não esperava que a vida de todos daqui seria terminada por causa de uma bomba...",
			"É uma pena, mas se caso alguém tenha a capacidade de desarmar isso tem um alicate em um dos armários nos escritórios....",
			"Mas dúvido que alguem vai fazer isso."
			
		],
	"Golem": [
			"Eae, eu sou o zelador daqui!",
			"Quer ouvir do meu rpg sobre LÁPIS?!",
			"Ah você quer saber onde ta a chave do banheiro?",
			"Se eu não me engano eu deixei ela no escritório do chefe",
			"Mas quem sabe um goblin não roubou ela?!",
			"Brincadeirinha",
			"Ou não...."
		],
	"Frank": [
			"Eu sou o Frank, sou segurança aqui...",
			"Mano! Essa música é muito boa!",
			"Ah tem uma bomba aqui?",
			"Não me importo enquanto essa música tiver tocando eu vou dançar até minha morte"
			
	],
	"Vampira": [
			"Hmmm, essa noticia da bomba me dxou tão... empolgada!",
			"Só de imaginar todos nós explodindo em pedaços me excita BASTANTE!",
			"Você quer desarmar essa bomba gatinho?",
			"Talvéz o terrorista tenha guardado a tal bomba em alguns dos banheiros, mas a porta ta emperrada então é dificil de entrar la",
			"Se pelo menos alguém consiguisse arrombar de alguma forma.❤️♡♡♡♡♡",
			"*ela se contorce de excitação*"
	],
	"Fantasma": [
			"Que?... Bomba?...",
			"Não ligo pra isso... Meu trabalho é mais importante...",
			"Oque ainda ta me encarando? vai fazer outra coisa moleque, procura em algumas caixas e armários qualquer coisa ai",
			"Deve ter algo utíl pra desarmar a tal bomba",
			"Agora me deixe terminar meu relatório, contas não se pagam sozinhas."
	],
	"Lapis": [
			"*ENCARA*",
			"*ENCARA MAIS AINDA*",
			"OQUE VOCÊ QUER SEU MALDITO",
			"NÃO TA VENDO QUE EU SOU UM LÁPIS?",
			"SIM UM MALDITO LÁPIS",
			"MINHA FUNÇÃO É FICAR PERTO DESSA ESTATUA ATÉ ESSA FESTA TERMINAR, E NÃO FALAR NADA",
			"OQUE UMA BOMBA?!",
			"NÃO É POSSIVEL QUE EU MORRERREI INTERPRETANDO UM MALDITO LÁPIS",
			"EU ME FORMEI EM TEATRO PARA SEGUIR O PAPEL DE UM GRANDE ATOR",
			"MAS NINGUEM GOSTA DA MINHA MAGNIFICA ATUAÇÃO....",
			"*ele começa a contar sobre sua vida e seus problemas, acho que é melhor deixa-lo ai*"
			
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
	"Caixa2": [
			"Essas caixas são realmente muito estranhas..."
	],
	"Estante": [
			"Uma estante na sala dos funcionários?!",
			"E tudo aqui são cadernos?!",
			"O que ta acontecendo nessa empresa??"
	], 
	"Estante2": [
			"Tem um caderno fora do lugar aqui...",
			"''Hurry and no one blows'' ?",
			"Uma aventura por... Golem?",
			"Parece que alguém tá aproveitando bem o intervalo na empresa."
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
			$Nome.visible = true
			npc =  get_parent().get_parent().get_node("Player").npc
			$Portrait.play(npc)
			if $Portrait.animation == ".":
				$Nome.visible = false
				$NomeShow.visible = false
			
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
