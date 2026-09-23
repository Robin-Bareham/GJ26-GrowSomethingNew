extends CanvasLayer

@onready var list: Array

var selected_box = -1
var previous = true #True = menu, false = pause

var style_selected: StyleBoxFlat = load("res://Assets/Styles/SBF_selected.tres")
var style_deselected: StyleBoxFlat = load("res://Assets/Styles/SBF_deselected.tres")

func _ready():
	list.append($MarginContainer/GridContainer/Start)
	list.append($MarginContainer/GridContainer/Controls)
	list.append($MarginContainer/GridContainer/Quit)
	list.append($MarginContainer/GridContainer/back)
	list.append($MarginContainer/GridContainer/Continue)
	list.append($MarginContainer/GridContainer/PControls)
	list.append($MarginContainer/GridContainer/Menu)
	list.append($MarginContainer/GridContainer/returntotitle)

func _process(delta):
	if(GlobalScript.currentState != GlobalScript.gameState.GAME):
		if(selected_box != -1 && GlobalScript.interact == 3):
			match selected_box:
				0:
					GlobalScript.nextState = GlobalScript.gameState.GAME
					GlobalScript.change_state = true
					GlobalScript.previousState = true
				1:
					GlobalScript.nextState = GlobalScript.gameState.CONTROLS
					GlobalScript.previousState = true
					GlobalScript.change_state = true
				2:
					get_tree().quit()
				3:
					if(GlobalScript.previousState):
						GlobalScript.nextState = GlobalScript.gameState.MENU
					else:
						GlobalScript.nextState = GlobalScript.gameState.PAUSE
					GlobalScript.change_state = true
				4:
					GlobalScript.nextState = GlobalScript.gameState.GAME
					GlobalScript.change_state = true
					GlobalScript.previousState = false
				5:
					GlobalScript.nextState = GlobalScript.gameState.CONTROLS
					GlobalScript.previousState = false
					GlobalScript.change_state = true
				6:
					GlobalScript.nextState = GlobalScript.gameState.MENU
					GlobalScript.change_state = true
					GlobalScript.previousState = true
					BackgroundMus.stream = load("res://Audio/B_ShatteredDreams.mp3")
					BackgroundMus.play()
				7:
					GlobalScript.nextState = GlobalScript.gameState.MENU
					GlobalScript.change_state = true
					GlobalScript.next_scene = "woods"
					GlobalScript.transition_scene = true
					GlobalScript.previousState = false
					GlobalScript.change_scene()	

func changeStyle(pos: int, active: bool):
	if(active):
		list[pos].add_theme_stylebox_override("panel",style_selected)
	else:
		list[pos].add_theme_stylebox_override("panel",style_deselected)

## BUTTON MOUSE ENTER EXITS, ONLY HAPPENS WHEN MENU IS VISIBLE




#START BUTTON
func _on_start_mouse_entered() -> void:
	changeStyle(0,true)
	selected_box = 0
func _on_start_mouse_exited() -> void:
	changeStyle(0,false)
	selected_box = -1

#CONTROLS BUTTON
func _on_controls_mouse_entered() -> void:
	changeStyle(1,true)
	selected_box = 1
func _on_controls_mouse_exited() -> void:
	changeStyle(1,false)
	selected_box = -1
	
#QUIT BUTTON
func _on_quit_mouse_entered() -> void:
	changeStyle(2,true)
	selected_box = 2
func _on_quit_mouse_exited() -> void:
	changeStyle(2,false)
	selected_box = -1


# CONTROLS BACK BUTTON
func _on_back_mouse_entered() -> void:
	changeStyle(3,true)
	selected_box = 3
func _on_back_mouse_exited() -> void:
	changeStyle(3,false)
	selected_box = -1

# CONTINUE BUTTON
func _on_continue_mouse_entered() -> void:
	changeStyle(4,true)
	selected_box = 4
func _on_continue_mouse_exited() -> void:
	changeStyle(4,false)
	selected_box = -1

# PAUSE CONTROLS
func _on_p_controls_mouse_entered() -> void:
	changeStyle(5,true)
	selected_box = 5
	
func _on_p_controls_mouse_exited() -> void:
	changeStyle(5, false)
	selected_box = -1

#MENUs

func _on_menu_mouse_entered() -> void:
	changeStyle(6,true)
	selected_box = 6
func _on_menu_mouse_exited() -> void:
	changeStyle(6,false)
	selected_box = -1



# RETURN TO TITLE FROM END

func _on_returntotitle_mouse_entered() -> void:
	changeStyle(7,true)
	selected_box = 7
func _on_returntotitle_mouse_exited() -> void:
	changeStyle(7,false)
	selected_box = -1
