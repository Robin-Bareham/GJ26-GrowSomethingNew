extends CanvasLayer

@onready var v_box_container = $BoxContainer
@onready var v_name = $BoxContainer/ImageContainer/Image/HBoxContainer/Name
@onready var v_text = $BoxContainer/TextContainer/HBoxContainer/Text
@onready var v_image = $BoxContainer/ImageContainer/Image
@onready var v_next = $BoxContainer/TextContainer/HBoxContainer/Next

@onready var v_option_container = $BoxContainer/TextContainer/OptionContainer
@onready var v_option1_panel = $BoxContainer/TextContainer/OptionContainer/HBoxContainer/Opt1 
@onready var v_option2_panel = $BoxContainer/TextContainer/OptionContainer/HBoxContainer/Opt2

var optDeselected: StyleBoxFlat = load("res://Assets/Styles/option_deselected.tres")
var optSelected: StyleBoxFlat = load("res://Assets/Styles/option_selected.tres")

var v_currently_active = false
var v_current_dialogue = []
var v_current_line = 3 #Always starts on line 3
#Option Dialogues
var v_current_question = 0
var v_opt1 = false
var v_opt2 = false
var v_opt_active = false

@onready var v_interaction_hb = get_tree().current_scene.get_node("Player").get_node("Interaction_HB")

func _ready():
	v_interaction_hb.dialogue_activation.connect(boxActivated)
	hideBox()
	pass

func _process(delta):
	progressDialogue()
	pass

func hideBox():
	GlobalScript.dialogue_open = false
	GlobalScript.can_move = true
	v_currently_active = false
	v_text.text = ""
	v_current_line = 3
	v_current_dialogue = []
	v_box_container.hide()
	v_option_container.hide()
	v_opt1 = false
	v_opt2 = false
	v_opt_active = false
	pass

func showBox(object: String):
	#Set statuses to true
	GlobalScript.dialogue_open = true
	GlobalScript.can_move = false
	v_currently_active = true
	#Get the lines of dialogue related to the object
	v_current_dialogue = GlobalScript.dialogue_dic[object]
	#Update Icon and Names
	v_name.text = v_current_dialogue[0] #Name of person talking
	v_next.text = ">"
	var style_box = v_image.get_theme_stylebox("panel") #Gets the panel's theme (Image)
	#Makes a path to new icon
	var temp_path = "res://Assets/Icons/" + str(v_current_dialogue[1]) + ".png" 
	#Gets if it's a question or not 0 is no question 1 + is there's a question on THIS line
	v_current_question = int(v_current_dialogue[2])
	if(style_box is StyleBoxTexture):
		#style_box = style_box.duplicate()
		style_box.texture = load(temp_path) #Changes Texture
		v_image.add_theme_stylebox_override("panel",style_box) #Updates theme to stylebox.
	
	v_box_container.show()
	pass
	
func alterBox(object: String):
	v_text.text = v_current_dialogue[v_current_line]
	pass

func progressDialogue():
	if(GlobalScript.dialogue_open):
		if(Input.is_action_just_pressed("interact") && !v_option_container.visible ):
			if(v_currently_active):
				#If there is to be a question answered / buttons.
				if(v_current_question == v_current_line):
					optActivated()
				else:
					v_option_container.hide()
					#Show the current dialogue
					v_text.text = v_current_dialogue[v_current_line]
				# If it's at the end of the dialogue, the next input will close it
				if( v_current_dialogue[v_current_line+1] == "0"):
					GlobalScript.dialogue_open = false
					v_next.text = "v"
				else:
					#If there's more dialogue, it'll move onto the next line
					v_current_line += 1
				pass
			pass
		#If there's an option to pick from
		if(v_option_container.visible):
			if(Input.is_action_just_pressed("interact") && v_opt_active && (v_opt1 || v_opt2 )):
				v_option_container.hide()
				v_opt_active = false
				#Show the current dialogue
				#Option 1 will always go to the next line, option 2 will always go to the line after that
				if(v_opt2):
					v_current_line += 1
				v_text.text = v_current_dialogue[v_current_line]
				#If it was option one, skips over option 2's outcome
				if(v_opt1):
					v_current_line += 1
				# If it's at the end of the dialogue, the next input will close it
				if( v_current_dialogue[v_current_line+1] == "0"):
					GlobalScript.dialogue_open = false
					v_next.text = "v"
				else:
					#If there's more dialogue, it'll move onto the next line
					v_current_line += 1
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
func boxActivated(type: String):
	
	if(!v_currently_active):
		showBox(type)
	else:
		hideBox()
	pass

func optActivated():
	v_opt1 = false
	v_opt2 = false
	v_next.text = ""
	v_option1_panel.add_theme_stylebox_override("panel",optDeselected)
	v_option2_panel.add_theme_stylebox_override("panel",optDeselected)
	v_text.text = v_current_dialogue[v_current_line][0]
	v_option1_panel.get_node("Opt1Text").text = v_current_dialogue[v_current_line][1]
	v_option2_panel.get_node("Opt2Text").text = v_current_dialogue[v_current_line][2]
	v_option_container.show()
	
	pass
