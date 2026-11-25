extends SubViewportContainer

var scenes : Array[PackedScene]
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
	current.process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	main.texte_annonce.text = current.get_phrase()
	current.est_joueur_1 = joueur

func lancement():
	current.en_cours = true
	current.process_mode = Node.PROCESS_MODE_INHERIT
	$"../AnimatedSprite2D".play("timer")


func _on_animated_sprite_2d_animation_finished() -> void:
	$"../AnimatedSprite2D".play("explosion")
	current.en_cours = false
	main.fin_minijeu()
