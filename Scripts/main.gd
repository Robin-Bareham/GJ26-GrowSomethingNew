extends Node2D

@onready var dia_ui = $DialogueBox
@onready var mini_ui = $minigame
@onready var const_ui = $ConstantUI
@onready var menu_ui = $menu
@onready var control_ui = $controls
@onready var pause_ui = $Pause
@onready var end_ui = $End
@onready var player = $Environment/Player

@onready var blindfold = $Environment/blindfold
@onready var waterpools = $WaterSplash

var grove_mus = "res://Audio/B_Grove_A9.mp3"
var menu_mus =  "res://Audio/B_ShatteredDreams.mp3"
var woods_mus = "res://Audio/B_End_LostInTime.mp3"

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
			if(GlobalScript.currentState == GlobalScript.gameState.GAME):
				const_ui.hideBg()
				playBg(woods_mus)
			else:
				if(GlobalScript.previousState):
					playBg(menu_mus)
				pass #if its one of the other states( Menus) play smthign else
				#If it's the end of the game
		"grove":
			const_ui.hideBg()
			player.changeCameraLimits(GlobalScript.cl_grove_l,GlobalScript.cl_grove_r,GlobalScript.cl_grove_b,GlobalScript.cl_grove_t)
			if(GlobalScript.day != 1):
				playBg(grove_mus)
				
func _process(delta):
	#For resetting certain nodes only available in the wood's scene
	if(GlobalScript.resetting_game && get_tree().get_current_scene().name == "woods"):
		blindfold.setVisib(true)
		GlobalScript.resetting_game = false
		var tree_list = []
		tree_list = get_tree().get_nodes_in_group("enviro")
		for i in tree_list.size():
			tree_list[i].reloadTextures()
		dia_ui.eventActivated("Start",2,"Start01")
		waterpools.show()
		waterpools.play("default")
		print_debug(str(GlobalScript.activate_cutscene) + " End of Woods Loading")
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
	#if(Input.is_action_just_pressed("test")):
		#GlobalScript.day_over = true
		#GlobalScript.activate_cutscene = true
		#dia_ui.eventActivated("test",2,"Temp_Cutscene1")
	if(Input.is_action_just_pressed("mouse_click") && GlobalScript.currentState != GlobalScript.gameState.GAME):
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
	
	if(!GlobalScript.resetting_game && GlobalScript.current_scene == "woods"):
		waterpools.play("default")
	
	#Changing Scenes Woods and Grove
	match GlobalScript.current_scene:
		"woods":
			if(GlobalScript.activate_cutscene):
				print_debug(str(GlobalScript.activate_cutscene) + " ManageStates")
				#Starting Cutscene
				if(GlobalScript.day == 1):
					#Starting Cutscene
					if(!GlobalScript.completed_events["Start"]):
						dia_ui.eventActivated("Start",2,"Start01")
						GlobalScript.completed_events["Start"] = true
						AllDia.dia_closing = false
						GlobalScript.trans_cutscene = false
					#Grove d1 cutscene
					elif(!GlobalScript.completed_events["D1Grove"] && GlobalScript.completed_events["Start"]):
						GlobalScript.trans_cutscene = true
						dia_ui.eventActivated("D1Grove",2,"Grove01")
						playBg(grove_mus)
						GlobalScript.completed_events["D1Grove"] = true
						AllDia.dia_closing = false
						
				GlobalScript.activate_cutscene = false
			
			if(GlobalScript.trans_cutscene && AllDia.dia_closing && GlobalScript.completed_events["D1Grove"]):
				GlobalScript.trans_cutscene = false
				AllDia.dia_closing = false
				transition("grove")
				GlobalScript.start_timer = true
			elif(AllDia.dia_closing):
				GlobalScript.trans_cutscene = false
				AllDia.dia_closing = false
				if(AllDia.lake_interacted):
					waterpools.hide()
				else:
					waterpools.show()
		"grove":				
			if(GlobalScript.day_over):
				#print_debug("Day over")
				if(GlobalScript.activate_cutscene):
					match GlobalScript.day:
						1:
							dia_ui.eventActivated("D1End",2,"D1End01")
							GlobalScript.completed_events["D1End"] = true
						2:
							dia_ui.eventActivated("D2End",2,"D2End01")
							GlobalScript.completed_events["D2End"] = true
						3:
							dia_ui.eventActivated("D3End",2,"D3End01")
							GlobalScript.completed_events["D3End"] = true
						4: 
							dia_ui.eventActivated("D4End",2,"D4End01")
							GlobalScript.completed_events["D4End"] = true
					GlobalScript.trans_cutscene = true
					AllDia.dia_closing = false
					GlobalScript.activate_cutscene = false
				#Changing to woods
				if(GlobalScript.trans_cutscene && AllDia.dia_closing):
					GlobalScript.trans_cutscene = false
					AllDia.dia_closing = false
					
					GlobalScript.day_over = false
					GlobalScript.timer_active = false
					GlobalScript.start_timer = false
					GlobalScript.minigame_active = false
					GlobalScript.activating_minigame = false
					if(GlobalScript.day != 4):
						GlobalScript.first_pile = true
						AllDia.lake_interacted = false
						GlobalScript.day += 1
						transition("woods")
					

func updateUI():
	match GlobalScript.currentState:
		GlobalScript.gameState.GAME:
			if(GlobalScript.previousState):
				resetGame()
			menu_ui.hide()
			pause_ui.hide()
		GlobalScript.gameState.MENU:
			menu_ui.show()
			pause_ui.hide()
			control_ui.hide()
			end_ui.hide()
		GlobalScript.gameState.CONTROLS:
			control_ui.show()
			menu_ui.hide()
			pause_ui.hide()
		GlobalScript.gameState.PAUSE:
			pause_ui.show()
			control_ui.hide()
		GlobalScript.gameState.END:
			end_ui.show()
			menu_ui.hide()
			pause_ui.hide()
			control_ui.hide()

### MAKE SURE THIS IS WORKING< ITS NOT WORKING ATM
func resetGame():
	#If current scene is grove, go to woods
	if(GlobalScript.current_scene == "grove"):
		GlobalScript.next_scene = "woods"
		GlobalScript.transition_scene = true
		GlobalScript.change_scene()	
	#If a dialogue was open, close it
	if(AllDia.dia_open):
		dia_ui.hideBox()
	#Make sure it's starting scene
	GlobalScript.reset_values()
	AllDia.lake_interacted = false
	player.position.x = GlobalScript.p_start_px
	player.position.y = GlobalScript.p_start_py
	#Sets Blindfold to visible.
	#Activates Start Cutscene
	GlobalScript.activate_cutscene = true
	GlobalScript.resetting_game = true
	playBg(woods_mus)

	
	
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
	GlobalScript.current_energy -= 10
	if(GlobalScript.current_energy <= 0 && GlobalScript.day == 4):
		GlobalScript.day_over = true
		GlobalScript.activate_cutscene = true
		return
	if(GlobalScript.minigame_goal_image != ""):
		dia_ui.boxActivated(GlobalScript.minigame_goal_image,0)	
	GlobalScript.minigame_goal_image = ""
	GlobalScript.minigame_active = false
	
	#Adjust Energy
	
			
func transition(type: String):
	GlobalScript.transition_scene = true
	GlobalScript.next_scene = type
	GlobalScript.change_scene()
	
func playBg(type: String):
	BackgroundMus.stream = load(type)
	BackgroundMus.play()
	
