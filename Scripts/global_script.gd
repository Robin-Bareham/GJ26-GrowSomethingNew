extends Node

var can_move = true
enum gameState{MENU,GAME,PAUSE,PUZZLE}
var currentState: gameState

var current_scene = "woods"
var transition_scene = false
var next_scene = ""
var previous_scene = "woods"
var game_end = false

var items = {
	"blindfold": false
}

func change_scene():
	if(transition_scene):
		var temp_path = "res://Scenes/" + next_scene + ".tscn"
		get_tree().change_scene_to_file(temp_path)
		transition_scene = false
		previous_scene = current_scene
		current_scene = next_scene
		next_scene = ""
