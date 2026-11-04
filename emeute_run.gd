extends MiniJeu

const Y = 800
const X_ini = -100
const V_X = 1280/60/3
const A_Y = 1

var x
var y
var v_y
var x_1
var x_2
var collision

@onready var Leo = $Leo
@onready var Gaambas = $Gaambas
@onready var Gaambas2 = $Gaambas2
@onready var Explosion = $Leo/Explosion
@onready var explosion = $explosion
@onready var emeute = $emeute

func _ready() -> void:
	x = X_ini
	y = Y
	v_y = 0
	collision = false
	
	#choix de l'emplacent des obstacles
	x_1 = randi() % 851 + 450
	x_2 = randi() % 851 + 450
	var distance = absi(x_1 - x_2)
	
	if(distance < 400 and distance > 100) :
		if(x_1 < x_2) :
			x_2 = x_2 + 400
		else :
			x_1 = x_1 + 400
	else : null
	
	Gaambas.position.x = x_1
	Gaambas2.position.x = x_2
	
	emeute.play()
	Explosion.visible = false

func _process(delta: float) -> void:
	if !collision :
		x = x + V_X
		
		if is_action_pressed() :
			if y >= Y :
				v_y = -25
				y = y + v_y
			else :
				v_y = v_y + 0.8
				y = y + v_y
		else :
			if y >= Y :
				y = Y
			else :
				v_y = v_y + 2
				y = y + v_y
				
		if (absi(x - x_2) < 20 or absi(x - x_1) < 20) and y > 630 :
			collision = true
			Explosion.visible = true
			Explosion.play()
			explosion.play()
	else : null
	
	Leo.position.x = x
	Leo.position.y = y
	
	if x >= 1240 :
		gagne = true

func get_phrase() -> String:
	return "yipee"
