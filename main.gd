extends Node2D

const gradation_intensite_globale = [1.5, 1.0, 1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9, 2.0, 2.2, 2.4, 2.6, 2.8, 3.0, 3.5, 4.0, 5.0, 10.0, 10, 10, 10, 10, 10]
const TEMPS_MAX = 250

var intensitee = 0
var transition = false
@export var vie = 3
@export var mini_jeux : Array[PackedScene]
@export var est_joueur1 = true
var en_cours = false
var compte = 0

var timer = 0

@onready var anim = $transition/AnimationPlayer
@onready var scenes = $scenes

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Container.hide()
	anim.play("dezoom")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if (!transition && (scenes.current == null || !scenes.current.en_cours) && en_cours):
		if (scenes.current.perdue):
			vie -= 1
			$Container.get_child(vie).play("perte")
		transition = true
		anim.play("dezoom")
	if en_cours:
		timer += delta

func fin_transition():
	transition = false

func ventre_transition():
	if vie > 0:
		if timer >= TEMPS_MAX:
			compte = -1
			anim.play("fin")
		else:
			anim.play("transition", -1, gradation_intensite_globale[intensitee], false)
			if (intensitee < 25 ):
				intensitee += 1
			compte += 1
	else:
		anim.play("fin")

func demarrer():
	en_cours = true
	transition = true
	anim.play("transition", -1, gradation_intensite_globale[intensitee], false)
	intensitee = 1

func fin_minijeu():
	anim.play("dezoom")
