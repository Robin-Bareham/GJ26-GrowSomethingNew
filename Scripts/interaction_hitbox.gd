extends Area2D

var v_interractable_list = []
var area_root
var v_in_search = false

@onready var v_dialogue_box = get_tree().current_scene.get_node("DialogueBox")

signal dialogue_activation(type: String, dia: int)
signal send_object(type: Node2D)


func _ready():
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
					else:
						dialogue_activation.emit(v_interractable_list[0],0) #Dialogue
					send_object.emit(area_root) #Object

func _on_area_entered(area: Area2D) -> void:
	area_root = area.get_parent().get_parent()
	v_in_search = false
	if(area_root.is_in_group("search")):
		v_in_search = true
	#Is it an interactable??
	if(area_root.is_in_group("interactables") && area.is_visible_in_tree()):
		area_root.setInteractable(true)
		updateObject()
		v_interractable_list.append(area_root.getName())


func _on_area_exited(area: Area2D) -> void:
	area_root = area.get_parent().get_parent()
	if(area_root.is_in_group("interactables") && area.is_visible_in_tree()):
		area_root.setInteractable(false)
		var index = v_interractable_list.find(area_root.getName())
		if index != -1:
			v_interractable_list.remove_at(index)
		
func changeNode(type:String):
	var index = v_interractable_list.find(area_root.getName())
	if index != -1:
		v_interractable_list.remove_at(index)
	area_root.setName(type)
	v_interractable_list.append(area_root.getName())
	
func updateObject():
	#If there's saving and loading, this is where you check
	#if objects have the right name for the items the player currently has.
	pass

	
