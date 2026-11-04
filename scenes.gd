extends SubViewportContainer

var scenes : Array[PackedScene]
@onready var texte = $"../transition/Label"
@onready var main = $".."
@onready var vue = $minijeu
var NB_SCENE

var last = -1
var lastlast = -1
var current : MiniJeu
var joueur = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scenes = $"..".mini_jeux
	NB_SCENE = scenes.size()
	joueur = $"..".est_joueur1

func choisir_nouvelle_scene():
	#suppression du mini jeu en cours
	if (current != null):
		current.free()
	
	var numero_scene = randi() % NB_SCENE
	#pour éviter d'avoir deux foix la même d'affilé
	while numero_scene == last || numero_scene == lastlast:
		numero_scene = randi() % NB_SCENE
	lastlast = last
	last = numero_scene
	
	#demmarrage du nouveau mini jeu
	current = scenes[numero_scene].instantiate()
	vue.add_child(current)
	texte.text = current.get_phrase()
	current.est_joueur_1 = joueur
		
func lancement():
	current.en_cours = true
	$"../AnimationPlayer".play("main")

func son_victoire_defaite():
	if current != null:
		if !current.gagne:
			$"../transition/SoundLose".play(0.0)
			$"../transition/ColorRect".visible = true
		else:
			$"../transition/SoundWin".play(0.0)
			$"../transition/ColorRect".visible = false
			$"../transition/WinConfettiLeft".emitting = true
			$"../transition/WinConfettiright".emitting = true
