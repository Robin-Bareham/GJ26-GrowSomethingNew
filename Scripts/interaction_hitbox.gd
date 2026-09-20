extends Area2D

var v_interractable_list = []
var area_root
var v_in_search = false
var v_in_scripted = false
var v_bg = ""


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
				transition("grove")
				GlobalScript.start_timer = true
			else:
				dialogue_activation.emit("NoBF",0)
				#Change position of player
				get_parent().position.y = GlobalScript.p_nobf_py
		else:
			v_interractable_list.append(area.getName())
			v_bg = area.getBg()
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
		index = v_interractable_list.find(area.getName())
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
	if(GlobalScript.items[type]):
		GlobalScript.items[type] = false
	else:
		GlobalScript.items[type] = true

func transition(type: String):
	GlobalScript.transition_scene = true
	GlobalScript.next_scene = type
	GlobalScript.change_scene()
	
