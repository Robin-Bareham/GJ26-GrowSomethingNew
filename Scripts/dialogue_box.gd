extends CanvasLayer

@onready var v_box_container = $"."
@onready var v_text = $BoxContainer/TextContainer/HBoxContainer/Text
@onready var v_image = $Image
@onready var v_next = $BoxContainer/TextContainer/HBoxContainer/Next

@onready var v_option_container = $BoxContainer/TextContainer/OptionContainer
@onready var v_option1_panel = $BoxContainer/TextContainer/OptionContainer/HBoxContainer/Opt1 
@onready var v_option2_panel = $BoxContainer/TextContainer/OptionContainer/HBoxContainer/Opt2

var optDeselected: StyleBoxFlat = load("res://Assets/Styles/option_deselected.tres")
var optSelected: StyleBoxFlat = load("res://Assets/Styles/option_selected.tres")

var v_currently_active = false
var v_current_dialogue = []
var v_current_line = 0
var v_current_node #The object we're interacting with if applicable
var v_new_node = ""
#Option Dialogues
var v_current_question = 0
var v_opt1 = false
var v_opt2 = false
var v_opt_active = false

#What it can receive from
@onready var v_interaction_hb = get_tree().current_scene.get_node("Player").get_node("Interaction_HB")
signal change_node(type: String)

func _ready():
	v_interaction_hb.dialogue_activation.connect(boxActivated)
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
	v_current_line = 0
	v_current_dialogue = []
	v_box_container.hide()
	v_option_container.hide()
	v_opt1 = false
	v_opt2 = false
	v_opt_active = false
	pass

func showBox(object: String):
	#Set statuses to true
	AllDia.dia_open = true
	GlobalScript.can_move = false
	#Get the lines of dialogue related to the object
	v_current_dialogue = AllDia.dia_dic[object]
	#Update Text
	v_text.text = v_current_dialogue[v_current_line][2]
	v_next.text = v_current_dialogue[v_current_line][3]
	#Update Icon
	editImages()
	v_box_container.show()
	v_currently_active = true
	pass
	
func alterBox(object: String):
	v_text.text = v_current_dialogue[v_current_line]
	pass

func progressDialogue():
	if(AllDia.dia_open):
		# NORMAL dialogue Box		
		if(Input.is_action_just_pressed("interact") && !v_option_container.visible ):
			print_debug("I'M BACK IN THE BUILDING")
			if(v_currently_active):
				#If there is to be a question answered / buttons.
				if(v_current_dialogue[v_current_line][1] > 0):
					alternateText()
				else:
					v_option_container.hide()
					nextLine()
		# Option Box
		if(v_option_container.visible):
			if(Input.is_action_just_pressed("interact") && v_opt_active && (v_opt1 || v_opt2 )):
				v_option_container.hide()
				v_opt_active = false
				#Show the current dialogue
				#Jump to the line as stated in pos 6 (opt 1) and 7 (opt2)
				if(v_opt2):
					v_current_line = v_current_dialogue[v_current_line][7]
				else:
					v_current_line = v_current_dialogue[v_current_line][6]
				nextLine()
				
			#Choosing between options
			if(Input.is_action_just_pressed("walk_right") && !v_opt2):
				v_opt1 = false
				v_opt2 = true
				v_option2_panel.add_theme_stylebox_override("panel",optSelected)
				v_option1_panel.add_theme_stylebox_override("panel",optDeselected)
			if(Input.is_action_just_pressed("walk_left") && !v_opt1):
				v_opt1 = true
				v_opt2 = false
				v_option2_panel.add_theme_stylebox_override("panel",optDeselected)
				v_option1_panel.add_theme_stylebox_override("panel",optSelected)
			#Stops it from answering on the first time
			if(!v_opt_active):
				v_opt_active = true


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
	
	pass

func editImages():
	#Gets style box
	var style_box = v_image.get_theme_stylebox("panel")
	#Creats path to icon
	var temp_path = "res://Assets/Icons/" + str(v_current_dialogue[v_current_line][0]) + ".png"
	#Updates stylebox
	if(style_box is StyleBoxTexture):
		style_box.texture = load(temp_path)
		v_image.add_theme_stylebox_override("panel",style_box) #Updates Image
	pass

func nextLine():
	v_text.text = v_current_dialogue[v_current_line][2]
	#If at the end of the dialogue, the next input will close it
	v_next.text = v_current_dialogue[v_current_line][3]
	editImages()
	if(v_current_dialogue[v_current_line][3] == "v"):
		AllDia.dia_open = false
		AllDia.dia_closing = true
	else:
		v_current_line += 1

func alternateText():
	#If the dialogue is an option
	if(v_current_dialogue[v_current_line][1] == 1):
		optActivated()
	#If the dialogue edits a node or item
	elif(v_current_dialogue[v_current_line][1] == 2):
		if(v_current_dialogue[v_current_line][4] == "N/A"): #If there's no item to change
			v_new_node = v_current_dialogue[v_current_line][5] #Change node's name to new object
		else:
			changingItem(v_current_dialogue[v_current_line][5])
		nextLine()
	#If the dialogue changes scene
	elif(v_current_dialogue[v_current_line][1] == 3):
		GlobalScript.transition_scene = true
		GlobalScript.next_scene = v_current_dialogue[v_current_line][5]
		nextLine()
	pass

func changingItem(item: String):
	if(GlobalScript.items[item]):
		GlobalScript.items[item] = false
	else:
		GlobalScript.items[item] = true
	v_new_node = v_current_dialogue[v_current_line][5]

#SIGNALS

func receiveNode(type: Node2D):
	v_current_node = type

func boxActivated(type: String):
	
	if(!v_currently_active):
		showBox(type)
	else:
		hideBox()
		if(v_new_node!= ""):
			change_node.emit(v_new_node)
			v_new_node = ""
