extends CanvasModulate

var mini_jeu : MiniJeu
@export var scene_a_tester : PackedScene

@onready var vue = $SubViewportContainer/SubViewport

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mini_jeu = scene_a_tester.instantiate()
	vue.add_child(mini_jeu)
	$AnimationPlayer.play("main")


func debut():
	mini_jeu.en_cours = true


func fin():
	if mini_jeu.gagne :
		print("gagné")
	else:
		print("perdu")
	mini_jeu.free()
	mini_jeu = scene_a_tester.instantiate()
	vue.add_child(mini_jeu)         
	mini_jeu.en_cours = false
	$AnimationPlayer.stop()
	$AnimationPlayer.play("main")
