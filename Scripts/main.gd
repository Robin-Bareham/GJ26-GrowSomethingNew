extends Node2D

@onready var dia_ui = $DialogueBox
@onready var mini_ui = $minigame
@onready var player = $Player


func _ready():
	GlobalScript.currentState = GlobalScript.gameState.GAME
	
	var curScn = GlobalScript.current_scene
	var prevScn = GlobalScript.previous_scene
	#Change Player's Camera limits when entering a scene
	match curScn:
		"woods":
			player.changeCameraLimits(GlobalScript.cl_woods_l,GlobalScript.cl_woods_r,GlobalScript.cl_woods_b,GlobalScript.cl_woods_t)
		"grove":
			player.changeCameraLimits(GlobalScript.cl_grove_l,GlobalScript.cl_grove_r,GlobalScript.cl_grove_b,GlobalScript.cl_grove_t)
	
	
func _process(delta):
	keyInputs()
	if(GlobalScript.activating_minigame):
		activateMinigame()

func keyInputs():
	GlobalScript.interact = 0
	GlobalScript.choose = 0
	if(Input.is_action_just_pressed("interact")):
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
	

func deactivateMinigame():
	mini_ui.hide()

func _on_to_grove_body_entered(body: Node2D) -> void:
	if(body.has_method("player")):
		if(GlobalScript.items["Blindfold"]):
			GlobalScript.transition_scene = true
			GlobalScript.next_scene = "grove"
			GlobalScript.change_scene()
		else:
			AllDia.scripted = true
			dia_ui.boxActivated("NoBF",0)
			player.position.x = GlobalScript.p_nobf_px
			player.position.y = GlobalScript.p_nobf_py
