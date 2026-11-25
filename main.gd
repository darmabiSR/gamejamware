extends Node2D

const gradation_intensite_globale = [1.5, 1.0, 1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9, 2.0, 2.2, 2.4, 2.6, 2.8, 3.0, 3.5, 4.0, 5.0, 10.0, 10, 10, 10, 10, 10]

var transition = false
@export var vie = 3
@export var mini_jeux : Array[PackedScene]
@export var est_joueur1 = true
@export var noeud_vies : Node2D
var en_cours = false
var compte = 0
var vitesse_transition = 1

var timer = 0

@export var score_affichage : Node2D
@export var texte_annonce : Label
@export var anim : AnimationPlayer
@onready var scenes = $scenes

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim.play("dezoom")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_vie():
	compte += 1
	if scenes.current != null && !scenes.current.gagne:
		vie -= 1
		noeud_vies.get_child(vie).play("default")

func transition_score():
	var frame_dixaine = int(compte / 10)
	var frame_unite = int(compte) % 10
	var affichage_score = score_affichage.get_children()
	
	var duree_clignatement = 0.4 * vitesse_transition
	var tween_unite = create_tween()
	var tween_dixaine = create_tween()
	for i in 3:
		tween_unite.tween_property(affichage_score[0], "frame", 10, 0)
		tween_dixaine.tween_property(affichage_score[1], "frame", 10, 0)
		tween_unite.tween_interval(duree_clignatement / 2)
		tween_dixaine.tween_interval(duree_clignatement / 2)
		tween_unite.tween_property(affichage_score[0], "frame", frame_unite, 0)
		tween_dixaine.tween_property(affichage_score[1], "frame", frame_dixaine, 0)
		tween_unite.tween_interval(duree_clignatement / 2)
		tween_dixaine.tween_interval(duree_clignatement / 2)

func transition_disk():
	scenes.choisir_nouvelle_scene()
	$transition/disk.self_modulate = scenes.current.couleur
	texte_annonce.label_settings.font_color = scenes.current.couleur
	anim.play("disque", -1, vitesse_transition)

func transition_chargement():
	anim.play("chargement")
	var duree = 2.0 / vitesse_transition
	var appartion_annonce = duree - 0.5
	var tween_transition = create_tween()
	tween_transition.tween_callback(transition_zoom).set_delay(duree)
	tween_transition.tween_property(texte_annonce, "visible", false, 0)
	create_tween().tween_callback(transition_texte).set_delay(appartion_annonce)

func transition_texte():
	var tween = create_tween()
	texte_annonce.position = Vector2(-3.5 * 1280, -3.5 * 960)
	texte_annonce.scale = Vector2(8.0, 8.0)
	texte_annonce.visible = true
	tween.tween_property(texte_annonce, "position", Vector2(0,-200), 0.2)
	create_tween().tween_property(texte_annonce, "scale", Vector2(1.0, 1.0), 0.2)
	

func transition_zoom():
	anim.play("zoom")

func demarrer():
	scenes.lancement()

func fin_minijeu():
	anim.play("dezoom")
