@abstract
class_name MiniJeu extends Node

var en_cours = false
var gagne = false
var est_joueur_1 = true

@abstract
func get_phrase() -> String

#idique si le bouton action a commencé à être appuyé à la frame courrante
func is_action_just_pressed() -> bool:
	if !en_cours: #ne pas prendre en compte les input avant le début du minijeu
		return false
	if est_joueur_1:
		return Input.is_action_just_pressed("actionJ1")
	else:
		return Input.is_action_just_pressed("actionJ2")
		
func is_action_pressed() -> bool:
	if !en_cours: #ne pas prendre en compte les input avant le début du minijeu
		return false
	if est_joueur_1:
		return Input.is_action_pressed("actionJ1")
	else:
		return Input.is_action_pressed("actionJ2")
		
func is_haut_just_pressed() -> bool:
	if !en_cours: #ne pas prendre en compte les input avant le début du minijeu
		return false
	if est_joueur_1:
		return Input.is_action_just_pressed("hautJ1")
	else:
		return Input.is_action_just_pressed("hautJ2")
		
func is_haut_pressed() -> bool:
	if !en_cours: #ne pas prendre en compte les input avant le début du minijeu
		return false
	if est_joueur_1:
		return Input.is_action_pressed("hautJ1")
	else:
		return Input.is_action_pressed("hautJ2")
		
func is_droite_just_pressed() -> bool:
	if !en_cours: #ne pas prendre en compte les input avant le début du minijeu
		return false
	if est_joueur_1:
		return Input.is_action_just_pressed("droiteJ1")
	else:
		return Input.is_action_just_pressed("droiteJ2")
		
func is_droite_pressed() -> bool:
	if !en_cours: #ne pas prendre en compte les input avant le début du minijeu
		return false
	if est_joueur_1:
		return Input.is_action_pressed("droiteJ1")
	else:
		return Input.is_action_pressed("droiteJ2")
		
func is_bas_just_pressed() -> bool:
	if !en_cours: #ne pas prendre en compte les input avant le début du minijeu
		return false
	if est_joueur_1:
		return Input.is_action_just_pressed("basJ1")
	else:
		return Input.is_action_just_pressed("basJ2")
		
func is_bas_pressed() -> bool:
	if !en_cours: #ne pas prendre en compte les input avant le début du minijeu
		return false
	if est_joueur_1:
		return Input.is_action_pressed("basJ1")
	else:
		return Input.is_action_pressed("basJ2")
		
func is_gauche_just_pressed() -> bool:
	if !en_cours: #ne pas prendre en compte les input avant le début du minijeu
		return false
	if est_joueur_1:
		return Input.is_action_just_pressed("gaucheJ1")
	else:
		return Input.is_action_just_pressed("gaucheJ2")
		
func is_gauche_pressed() -> bool:
	if !en_cours: #ne pas prendre en compte les input avant le début du minijeu
		return false
	if est_joueur_1:
		return Input.is_action_pressed("gaucheJ1")
	else:
		return Input.is_action_pressed("gaucheJ2")
		
func get_axis() -> Vector2:
	if !en_cours: #ne pas prendre en compte les input avant le début du minijeu
		return Vector2(0,0)
	if est_joueur_1:
		return Vector2(Input.get_axis("gaucheJ1", "droiteJ1"), Input.get_axis("basJ1", "hautJ1"))
	else:
		return Vector2(Input.get_axis("gaucheJ2", "droiteJ2"), Input.get_axis("basJ2", "hautJ2"))
