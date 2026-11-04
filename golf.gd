extends MiniJeu

const VITESSE_ANGULAIRE = 5
const PUISSANCE_TIRE = 1000
const FROTTEMENT = 0.98

const DIST_MIN = 300
const DIST_MAX = 400

const POINT_HORIZON = -971
const POINT_1_1 = 560

var tiree = false
@onready var visee : Node2D = $racine/balle/visee
@onready var balle = $racine/balle
@onready var trou = $racine/trou

func _ready() -> void:
	$racine/trou/Sprite2D/AnimatedSprite2D.play("default")
	
	#choix de l'emplacent du trou
	var r1 = randf()
	var r2 = randf()
	var dist = r1 * DIST_MIN + (1 - r1) * DIST_MAX
	var angle = r2 * 6.28 #2pi
	trou.position = balle.position + (Vector2(1,0).rotated(angle) * dist)
	
	#effet de perspective
	trou.scale.x = (trou.position.y - POINT_HORIZON) / (POINT_1_1 - POINT_HORIZON)
	trou.scale.y = balle.scale.x
	

func _process(delta: float) -> void:
	if !tiree:
		var stick = get_axis()
		if stick:
			if abs(stick.angle_to(Vector2(1,0)) - visee.rotation) < PI + 0.1:
				visee.rotation = move_toward(visee.rotation, stick.angle_to(Vector2(1,0)), delta * VITESSE_ANGULAIRE)
			elif visee.rotation < 0:
				visee.rotation = move_toward(visee.rotation, stick.angle_to(Vector2(1,0)) - 2*PI, delta * VITESSE_ANGULAIRE)
			else:
				visee.rotation = move_toward(visee.rotation, stick.angle_to(Vector2(1,0)) + 2*PI, delta * VITESSE_ANGULAIRE)
			visee.rotation = fmod(visee.rotation, 2 * PI)
			
		if is_action_just_pressed():
			tirer()
			
	else:
		balle.velocity *= FROTTEMENT
		balle.move_and_slide()
		#effet de perspective
		balle.scale.x = (balle.position.y - POINT_HORIZON) / (POINT_1_1 - POINT_HORIZON)
		balle.scale.y = balle.scale.x

func get_phrase() -> String:
	return "dans le trou !"
	
func tirer():
	$AudioStreamPlayer2.play(0.2)
	visee.visible = false
	tiree = true
	balle.velocity = Vector2(1,0).rotated(visee.rotation) * PUISSANCE_TIRE

func _on_trou_body_entered(body: Node2D) -> void:
	$AudioStreamPlayer.play(9.17)
	gagne = true
	balle.visible = false
