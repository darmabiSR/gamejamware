extends MiniJeu

const HAUTEUR = 450

@onready var perso = $racine/CharacterBody2D

func _ready() -> void:
	$racine/Control/mur_variable.position.y = randf() * HAUTEUR
	if $racine/Control/mur_variable.position.y > 240:
		perso.signe = -1
	$racine/win/AnimatedSprite2D.play("default")

func _process(delta: float) -> void:
	pass

func get_phrase() -> String:
	return "s'immicer"

func _on_win_area_entered(area: Area2D) -> void:
	if perso.en_vie:
		$AudioStreamPlayer.play()
		gagne = true
		perso.win_anim = true
		#animation de victoire
		$racine/win/AnimatedSprite2D.play("default", -3, true)
		var tween = perso.create_tween()
		tween.tween_property(perso, "position", Vector2(976, 480), 0.2)
