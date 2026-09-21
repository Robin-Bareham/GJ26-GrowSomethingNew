extends Area2D

var v_interractable_list = []
var area_root
var v_in_search = false
var v_in_scripted = false
var v_bg = ""
var v_lake_dia = ""

@onready var v_dialogue_box = get_tree().current_scene.get_node("DialogueBox")

signal dialogue_activation(version: String, dia: int)
signal send_object(type: Node2D)
signal script_activation(version: String, dia: int, bg: String)


func _ready():
	v_dialogue_box.change_node.connect(changeNode)
	v_dialogue_box.change_item.connect(changeItem)
	pass
	
func _process(delta):
	playerInteraction()
	pass

func playerInteraction():
	# Activates dialogue from interaction if the player's within an object
	if(GlobalScript.interact == 1):
		match GlobalScript.currentState:
			GlobalScript.gameState.GAME:
				if(v_interractable_list.size() != 0 && AllDia.dia_open == false):
					#Sending signals to dialogue box
					if(v_in_search):
						dialogue_activation.emit(v_interractable_list[0],1)
					elif(v_in_scripted):
						script_activation.emit(v_interractable_list[0],2,v_bg)
					else:
						dialogue_activation.emit(v_interractable_list[0],0) #Dialogue
					send_object.emit(area_root) #Object

## AREA ENTERED AND EXITED

func _on_area_entered(area: Area2D) -> void:
	if(area.is_in_group("scripted")):
		#Instant should ONLY be for woods to grove
		if(area.getInst()):
			##Going into grove
			if(GlobalScript.items["Blindfold"]):
				if(GlobalScript.day == 1):
					GlobalScript.activate_cutscene = true
				else:
					transition("grove")
					GlobalScript.start_timer = true
			else:
				dialogue_activation.emit("NoBF",0)
				#Change position of player
				get_parent().position.y = GlobalScript.p_nobf_py
		else:
			# LAKE INTERACTIONS DIFFERENCECS
			v_lake_dia = decidingLake()
			v_interractable_list.append(v_lake_dia)
			v_in_scripted = true
	#Not a scripted AREA
	else:
		area_root = area.get_parent().get_parent()
		v_in_search = false
		if(area_root.is_in_group("search")):
			v_in_search = true
		#Is it an interactable??
		if(area_root.is_in_group("interactables") && area_root.getVisib()):
			area_root.setInteractable(true)
			v_interractable_list.append(area_root.getName())


func _on_area_exited(area: Area2D) -> void:
	var index = -1
	if(area.is_in_group("scripted")):
		v_in_scripted = false
		index = v_interractable_list.find(v_lake_dia)
		v_bg = ""
	#NOT A SCRIPTED AREA
	else:
		area_root = area.get_parent().get_parent()
		if(area_root.is_in_group("interactables") && area_root.getVisib()):
			area_root.setInteractable(false)
			index = v_interractable_list.find(area_root.getName())
	if index != -1:
		v_interractable_list.remove_at(index)
		
func changeNode(type:String):
	if(type == "LAKE"):
		
		v_interractable_list.remove_at(v_interractable_list.find(v_lake_dia))
		v_lake_dia = "LakeSil"
		v_interractable_list.append(v_lake_dia)
		return
	var index = v_interractable_list.find(area_root.getName())
	if(type == "HIDE"):
		if index != -1:
			v_interractable_list.remove_at(index)
			area_root.setVisib(false);
	else:
		if index != -1:
			v_interractable_list.remove_at(index)
		area_root.setName(type)
		v_interractable_list.append(area_root.getName())
	
func changeItem(type: String):
	if(type == "Blindfold"):
		AllDia.lake_interacted = false
	if(GlobalScript.items[type]):
		GlobalScript.items[type] = false
	else:
		GlobalScript.items[type] = true

func transition(type: String):
	GlobalScript.transition_scene = true
	GlobalScript.next_scene = type
	GlobalScript.change_scene()
	
func decidingLake():
	var p_name = "LakeSil"
	match GlobalScript.day:
		1:
			if(GlobalScript.items["Blindfold"]):
				p_name = "D1Lake2"
				v_bg = "Lake02"
			else:
				p_name = "D1Lake"
				v_bg = "Lake01"
		2:
			p_name = "D2Lake"
			v_bg = "Lake03"
		3:
			p_name = "D3Lake"
			v_bg = "Lake04"
		4:
			p_name = "D4Lake"
			v_bg = "Lake05"
	if(AllDia.lake_interacted):
		p_name = "LakeSil"
	AllDia.lake_interacted = true
	return p_name				
