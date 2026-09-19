extends Node2D

@onready var dia_ui = $DialogueBox
@onready var mini_ui = $minigame
@onready var const_ui = $ConstantUI
@onready var player = $Player

func _ready():
	GlobalScript.currentState = GlobalScript.gameState.GAME
	#Change Player's Camera limits when entering a scene
	match GlobalScript.current_scene:
		"woods":
			player.changeCameraLimits(GlobalScript.cl_woods_l,GlobalScript.cl_woods_r,GlobalScript.cl_woods_b,GlobalScript.cl_woods_t)
			player.position.x = GlobalScript.p_exitg_px
			player.position.y = GlobalScript.p_exitg_py
		"grove":
			player.changeCameraLimits(GlobalScript.cl_grove_l,GlobalScript.cl_grove_r,GlobalScript.cl_grove_b,GlobalScript.cl_grove_t)
			
	#TImer

func _process(delta):
	keyInputs()
	if(GlobalScript.activating_minigame):
		if(!GlobalScript.minigame_active):
			activateMinigame()
		else:
			deactivateMinigame()
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
				


func keyInputs():
	GlobalScript.interact = 0
	GlobalScript.choose = 0
	if(Input.is_action_just_pressed("interact")):
		if(!GlobalScript.minigame_active):
			if(AllDia.dia_open):
				GlobalScript.interact = 2
			else:
				GlobalScript.interact = 1
	if(Input.is_action_just_pressed("walk_right")):
		if(AllDia.dia_open):
			GlobalScript.choose = 2
	if(Input.is_action_just_pressed("walk_left")):
		if(AllDia.dia_open):
			GlobalScript.choose = 1

func activateMinigame():
	mini_ui.show()
	GlobalScript.can_move = false
	GlobalScript.activating_minigame = false
	GlobalScript.minigame_active = true
	#What is sent in is the image of what's being found.
	mini_ui.resetMinigame(GlobalScript.minigame_goal_image) 

func deactivateMinigame():
	mini_ui.hide()
	GlobalScript.can_move = true
	GlobalScript.activating_minigame = false
	GlobalScript.minigame_active = false
	#Adjust Energy
	GlobalScript.current_energy -= 10
	if(GlobalScript.current_energy <= 0):
		print_debug("Deactivating Minigame leads to day over")
		GlobalScript.day_over = true

func _on_to_grove_body_entered(body: Node2D) -> void:
	if(body.has_method("player")):
		if(GlobalScript.items["Blindfold"]):
			print_debug("transitioning to grove")
			transition("grove")
			GlobalScript.start_timer = true
			print_debug(GlobalScript.start_timer)
		else:
			AllDia.scripted = true
			dia_ui.boxActivated("NoBF",0)
			player.position.x = GlobalScript.p_nobf_px
			player.position.y = GlobalScript.p_nobf_py
			
func transition(type: String):
	GlobalScript.transition_scene = true
	GlobalScript.next_scene = type
	GlobalScript.change_scene()
