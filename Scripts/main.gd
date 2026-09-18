extends Node2D

@onready var dia_ui = $DialogueBox
@onready var player = $Player

func _ready():
	GlobalScript.currentState = GlobalScript.gameState.GAME
	
func _process(delta):
	keyInputs()

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

func _on_to_grove_body_entered(body: Node2D) -> void:
	if(body.has_method("player")):
		if(GlobalScript.items["Blindfold"]):
			GlobalScript.transition_scene = true
			GlobalScript.next_scene = "grove"
			GlobalScript.change_scene()
		else:
			AllDia.scripted = true
			dia_ui.scriptActivate("NoBF")
			player.position.x = GlobalScript.p_nobf_px
			player.position.y = GlobalScript.p_nobf_py
