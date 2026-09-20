extends Node2D

@onready var dia_ui = $DialogueBox
@onready var mini_ui = $minigame
@onready var const_ui = $ConstantUI
@onready var menu_ui = $menu
@onready var control_ui = $controls
@onready var pause_ui = $Pause
@onready var player = $Environment/Player

func _ready():
	if(GlobalScript.just_started):
		GlobalScript.currentState = GlobalScript.gameState.MENU
		menu_ui.show()
		GlobalScript.just_started = false
	#Change Player's Camera limits when entering a scene
	match GlobalScript.current_scene:
		"woods":
			player.changeCameraLimits(GlobalScript.cl_woods_l,GlobalScript.cl_woods_r,GlobalScript.cl_woods_b,GlobalScript.cl_woods_t)
			player.position.x = GlobalScript.p_start_px
			player.position.y = GlobalScript.p_start_py
		"grove":
			player.changeCameraLimits(GlobalScript.cl_grove_l,GlobalScript.cl_grove_r,GlobalScript.cl_grove_b,GlobalScript.cl_grove_t)

func _process(delta):
	keyInputs()
	manageStates()
	
func keyInputs():
	GlobalScript.interact = 0
	GlobalScript.choose = 0
	if(Input.is_action_just_pressed("interact")):
		if(!GlobalScript.minigame_active):
			if(AllDia.dia_open):
				GlobalScript.interact = 2
			else:
				GlobalScript.interact = 1
		else:
			if(AllDia.dia_open):
				GlobalScript.interact = 2
	if(Input.is_action_just_pressed("walk_right")):
		if(AllDia.dia_open):
			GlobalScript.choose = 2
	if(Input.is_action_just_pressed("walk_left")):
		if(AllDia.dia_open):
			GlobalScript.choose = 1
		
	if(Input.is_action_just_pressed("pause")):
		GlobalScript.nextState = GlobalScript.gameState.PAUSE
		GlobalScript.change_state = true
	if(Input.is_action_just_pressed("test")):
		dia_ui.eventActivated("test",2,"Temp_Cutscene1")
	if(Input.is_action_just_pressed("mouse_click")):
		GlobalScript.interact = 3

func manageStates():
	#If a minigame is to be activated
	if(GlobalScript.activating_minigame):
		if(!GlobalScript.minigame_active):
			activateMinigame()
		else:
			deactivateMinigame()
	#Changing States Menu, Pause, Game
	if(GlobalScript.change_state):
		GlobalScript.currentState = GlobalScript.nextState
		GlobalScript.change_state = false
		updateUI()
	
	match GlobalScript.current_scene:
		"woods":
			pass
		"grove":
			if(GlobalScript.day_over):
				if(GlobalScript.day == 4):
					#Initate end of game, quits for now
					get_tree().quit()
				transition("woods")
				GlobalScript.day_over = false
				GlobalScript.minigame_active = false
				GlobalScript.activating_minigame = false
				GlobalScript.timer_active = false
				GlobalScript.start_timer = false
				GlobalScript.day += 1
				GlobalScript.first_pile = true

func updateUI():
	match GlobalScript.currentState:
		GlobalScript.gameState.GAME:
			if(GlobalScript.previousState):
				#Reset Values
				pass
			menu_ui.hide()
			pause_ui.hide()
		GlobalScript.gameState.MENU:
			menu_ui.show()
			pause_ui.hide()
			control_ui.hide()
		GlobalScript.gameState.CONTROLS:
			control_ui.show()
			menu_ui.hide()
			pause_ui.hide()
		GlobalScript.gameState.PAUSE:
			pause_ui.show()
			control_ui.hide()

func activateMinigame():
	if(GlobalScript.first_pile):
		var name = "D" + str(GlobalScript.day) + "Pile"
		dia_ui.boxActivated(name,2)	
		GlobalScript.first_pile = false
	mini_ui.show()
	GlobalScript.can_move = false
	GlobalScript.activating_minigame = false
	GlobalScript.minigame_active = true
	#What is sent in is the image of what's being found.
	mini_ui.resetMinigame(GlobalScript.minigame_goal_image) 

func deactivateMinigame():
	mini_ui.hide()
	GlobalScript.activating_minigame = false
	GlobalScript.minigame_active = false
	if(GlobalScript.minigame_goal_image != ""):
		dia_ui.boxActivated(GlobalScript.minigame_goal_image,0)	
	GlobalScript.minigame_goal_image = ""
	#Adjust Energy
	GlobalScript.current_energy -= 10
	if(GlobalScript.current_energy <= 0):
		GlobalScript.day_over = true
			
func transition(type: String):
	GlobalScript.transition_scene = true
	GlobalScript.next_scene = type
	GlobalScript.change_scene()
	
