extends Node

var can_move = true
enum gameState{MENU,GAME,PAUSE,PUZZLE}
var currentState: gameState

var current_scene = "woods"
var transition_scene = false
var next_scene = ""
var previous_scene = "woods"
var game_end = false

#Transition Positions
var p_nobf_px = 1154.0
var p_nobf_py = 133.0

var interact = 0 #0 = No interact, 1 = Object Interact, 2 = Dialogue Interact
var choose = 0 #No choice, 1 = left, 2 = right, 3 = up, 4= down

var items = {
	"Blindfold": false
}

func change_scene():
	if(transition_scene):
		var temp_path = "res://Scenes/" + next_scene + ".tscn"
		get_tree().change_scene_to_file(temp_path)
		transition_scene = false
		previous_scene = current_scene
		current_scene = next_scene
		next_scene = ""
