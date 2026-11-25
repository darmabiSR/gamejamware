extends CanvasModulate

var mini_jeu : MiniJeu
@export var scene_a_tester : PackedScene

@onready var vue = $SubViewportContainer/SubViewport

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mini_jeu = scene_a_tester.instantiate()
	vue.add_child(mini_jeu)
	mini_jeu.process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	var tween = create_tween()
	tween.tween_property(self, "color", Color(1,1,1), 1.0)
	tween.tween_callback(debut)

func debut():
	mini_jeu.en_cours = true
	mini_jeu.process_mode = Node.PROCESS_MODE_INHERIT
	$AnimatedSprite2D.play("timer")


func fin():
	if mini_jeu.gagne :
		print("gagné")
	else:
		print("perdu")
	mini_jeu.free()
	mini_jeu = scene_a_tester.instantiate()
	vue.add_child(mini_jeu)         
	mini_jeu.en_cours = false
	mini_jeu.process_mode = Node.PROCESS_MODE_WHEN_PAUSED
	var tween = create_tween()
	tween.tween_property(self, "color", Color(1,1,1), 1.0)
	tween.tween_callback(debut)


func _on_animated_sprite_2d_animation_finished() -> void:
	mini_jeu.en_cours = false
	var tween = create_tween()
	tween.tween_property(self, "color", Color(0,0,0), 0.3)
	tween.tween_callback(fin)
	$AnimatedSprite2D.play("explosion")
