extends CharacterBody2D

const SPEED = 400
const ACC = 3000
const VITESSE_ANGULAIRE = 1.4

@onready var racine : MiniJeu = $"../.."
var en_vie = true
var win_anim = false
var signe = 1

func _physics_process(delta: float) -> void:
	if en_vie && !win_anim:
		rotate(VITESSE_ANGULAIRE * delta * signe)
		var dir = racine.get_axis()
		dir.y *= -1
		velocity = velocity.move_toward(dir * SPEED, delta * ACC)

		if move_and_slide():
			racine.gagne = false
			en_vie = false
			$"../../degat".play()
			$Sprite2D.modulate = Color(2, 0.1, 0.1, 1)
			$Sprite2D.create_tween().tween_property($Sprite2D, "modulate", Color(1,1,1,0), 0.8)
	if win_anim:
		rotate(4 * VITESSE_ANGULAIRE * delta * signe)
