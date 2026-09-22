extends Node

var just_started = true

var can_move = true
enum gameState{MENU,GAME,PAUSE,CONTROLS,END}
var currentState: gameState
var nextState: gameState
var previousState = true
var change_state = false

var activate_cutscene = false

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

var trans_cutscene = false

#Transition Positions
var p_nobf_py = -165.0
var p_exitg_px = 639
var p_exitg_py = 271
var p_start_px = 39.0
var p_start_py = 182.0

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

var completed_events = {
	"Start" : false,
	"D1Grove" : false,
	"D1End" : false,
	"D2End" : false,
	"D3End" : false,
	"D4End" : false
}

func change_scene():
	if(transition_scene):
		var temp_path = "res://Scenes/" + next_scene + ".tscn"
		get_tree().change_scene_to_file(temp_path)
		transition_scene = false
		previous_scene = current_scene
		current_scene = next_scene
		next_scene = ""
		
func reset_values():
	next_scene = "woods"
	change_scene()
	previousState = true
	change_state = false
	minigame_active = false
	activating_minigame = false
	minigame_goal_image = ""
	first_pile = true
	items["Blindfold"] = false
		
	current_energy = 100
	day = 1
	day_over = false
	start_timer = false
	timer_active = false
	transition_scene = false

	game_end = false


func get_audio_player():
	return get_tree().current_scene.get_node("Environment").get_node("Player").get_node("Interaction_HB").get_node("AudioStreamPlayer2D")
