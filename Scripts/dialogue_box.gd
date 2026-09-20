extends CanvasLayer

@onready var v_root = $"."
@onready var v_box_container = $BoxContainer
@onready var v_text = $BoxContainer/TextContainer/HBoxContainer/Text
@onready var v_next = $BoxContainer/TextContainer/HBoxContainer/Next
@onready var v_name = $BoxContainer/MarginContainer/Name

@onready var v_option_container = $BoxContainer/TextContainer/OptionContainer
@onready var v_option1_panel = $BoxContainer/TextContainer/OptionContainer/HBoxContainer/Opt1 
@onready var v_option2_panel = $BoxContainer/TextContainer/OptionContainer/HBoxContainer/Opt2

var optDeselected: StyleBoxFlat = load("res://Assets/Styles/option_deselected.tres")
var optSelected: StyleBoxFlat = load("res://Assets/Styles/option_selected.tres")

var v_currently_active = false
var v_current_dialogue = []
var v_current_line = -1
var v_current_node #The object we're interacting with if applicable
var v_new_node = ""
var v_new_item = ""
#Option Dialogues
var v_current_question = 0
var v_opt1 = false
var v_opt2 = false
var v_opt_active = false
var v_dia_type
#Piles
var v_current_pile = ""

#What it can receive from
@onready var v_interaction_hb = get_tree().current_scene.get_node("Environment").get_node("Player").get_node("Interaction_HB")
@onready var v_bg = get_tree().current_scene.get_node("ConstantUI")
signal change_node(type: String)
signal change_item(type: String)

func _ready():
	v_interaction_hb.dialogue_activation.connect(boxActivated)
	v_interaction_hb.script_activation.connect(eventActivated)
	v_interaction_hb.send_object.connect(receiveNode)
	hideBox()
	pass

func _process(delta):
	progressDialogue()
	pass

func hideBox():
	AllDia.dia_open = false
	GlobalScript.can_move = true
	v_currently_active = false
	v_text.text = ""
	v_current_line = -1
	v_current_dialogue = []
	v_root.hide()
	v_option_container.hide()
	v_opt1 = false
	v_opt2 = false
	v_opt_active = false
	v_bg.hideBg()
	if(v_new_node!= ""):
		change_node.emit(v_new_node)
		v_new_node = ""
	if(v_new_item!= ""):
		change_item.emit(v_new_item)
		v_new_item = ""

func showBox(object: String):
	#Set statuses to true
	AllDia.dia_open = true
	GlobalScript.can_move = false
	#Get the lines of dialogue related to the object
	if(v_dia_type == 0):
		v_current_dialogue = AllDia.dia_dic[object]
	elif(v_dia_type == 1):
		v_current_dialogue = AllDia.pile_dic["pile"]
		v_current_pile = object #Name of goal image
	else:
		v_current_dialogue = AllDia.scripted_dia[object]
		v_current_pile = object #reusing name specifically for end of game
	v_root.show()
	v_currently_active = true
	pass

func progressDialogue():
	if(GlobalScript.interact == 2):
		# NORMAL dialogue Box		
		if(!v_option_container.visible ):
			# does this line have a v on it?
			if(v_next.text == "v"):
				if(v_current_pile == "D4End"):
					GlobalScript.nextState = GlobalScript.gameState.END
					GlobalScript.change_state = true
				hideBox() #end the dialogue
				return
			nextLine(-1)
		# Option Box
		if(v_option_container.visible):
			if(v_opt1 || v_opt2 ):
				v_option_container.hide()
				#Show the current dialogue
				#Choosing to search a pile or not
				if(v_dia_type == 1):
					if(v_opt2):
						hideBox()
						return
					else:
						hideBox()
						GlobalScript.activating_minigame = true
						GlobalScript.minigame_goal_image = v_current_pile
						v_new_node = "HIDE"
						return
				#Jump to the line as stated in pos 6 (opt 1) and 7 (opt2)
				var indexJump
				if(v_opt2):
					indexJump = v_current_dialogue[v_current_line][7]
				else:
					indexJump = v_current_dialogue[v_current_line][6]
				nextLine(indexJump)
	#Switch between options if Option Box is visible.
	if(v_option_container.visible && (GlobalScript.choose == 1 || GlobalScript.choose == 2)):
		if(GlobalScript.choose == 2 && !v_opt2):
			v_opt1 = false
			v_opt2 = true
			v_option2_panel.add_theme_stylebox_override("panel",optSelected)
			v_option1_panel.add_theme_stylebox_override("panel",optDeselected)
		if(GlobalScript.choose == 1 && !v_opt1):
			v_opt1 = true
			v_opt2 = false
			v_option2_panel.add_theme_stylebox_override("panel",optDeselected)
			v_option1_panel.add_theme_stylebox_override("panel",optSelected)
			
func optActivated():
	v_opt1 = false
	v_opt2 = false
	v_next.text = ""
	v_option1_panel.add_theme_stylebox_override("panel",optDeselected)
	v_option2_panel.add_theme_stylebox_override("panel",optDeselected)
	v_text.text = v_current_dialogue[v_current_line][2]
	v_option1_panel.get_node("Opt1Text").text = v_current_dialogue[v_current_line][4]
	v_option2_panel.get_node("Opt2Text").text = v_current_dialogue[v_current_line][5]
	v_option_container.show()

func nextLine(jump: int):
	if(jump > -1):
		v_current_line = jump
	else:
		v_current_line += 1
	#Change text
	v_text.text = v_current_dialogue[v_current_line][2]
	#Change Next symbol
	v_next.text = v_current_dialogue[v_current_line][3]
	#Change Name
	v_name.text = v_current_dialogue[v_current_line][0]
	#Checks for extra changes
	alternateText()
	
func alternateText():
	## If options are to be activated ##
	v_option_container.hide()
	
	## If it's going to be chosing an opition
	if(v_current_dialogue[v_current_line][1] == 1):
		optActivated()
		
	##If the dialogue edits a node or item
	elif(v_current_dialogue[v_current_line][1] == 2):
		## Changing an item
		if(v_current_dialogue[v_current_line][4] != "N/A"):
			v_new_item = v_current_dialogue[v_current_line][4]
		## Changing node
		if(v_current_dialogue[v_current_line][5] != "N/A"):
			v_new_node = v_current_dialogue[v_current_line][5]
			
	##If the dialogue changes scene
	elif(v_current_dialogue[v_current_line][1] == 3):
		GlobalScript.transition_scene = true
		GlobalScript.next_scene = v_current_dialogue[v_current_line][5]
		
	##Change background image
	elif(v_current_dialogue[v_current_line][1] == 4):
		#Change bg
		v_bg.changeBg(v_current_dialogue[v_current_line][4])

#SIGNALS

func receiveNode(type: Node2D):
	v_current_node = type

func boxActivated(version: String, dia: int):
	
	if(!v_currently_active):
		v_dia_type = dia
		showBox(version)
		nextLine(-1)
	
func eventActivated(version: String, dia: int, bg: String ):
	if(!v_currently_active):
		v_dia_type = dia
		showBox(version)
		nextLine(-1)
		v_bg.changeBg(bg)
		v_bg.showBg()
