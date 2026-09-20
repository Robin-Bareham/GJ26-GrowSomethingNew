extends Node

var just_started = true

var can_move = true
enum gameState{MENU,GAME,PAUSE,CONTROLS}
var currentState: gameState
var nextState: gameState
var previousState = true
var change_state = false



var minigame_active = false
var activating_minigame = false
var minigame_goal_image = ""
var first_pile = true

#Day Attribues
var max_energy = 100
var max_time = 60
var current_energy = 100
var day = 1
var day_over = false
var start_timer = false
var timer_active = false

# Possible scenes: woods, grove
var transition_scene = false
var next_scene = ""
var current_scene = "woods"
var previous_scene = "woods"
var game_end = false


#Transition Positions
var p_nobf_py = -165.0
var p_exitg_px = 639
var p_exitg_py = 271
var p_start_px = -108.0
var p_start_py = 36

#Camera limits per scene
var cl_woods_l = -250
var cl_woods_t = 0
var cl_woods_r = 1900
var cl_woods_b = 1080
var cl_grove_l = -430
var cl_grove_t = -234
var cl_grove_r = 2403
var cl_grove_b = 1120

#Handling key inputs within main so it's not within tons of scripts
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
		
