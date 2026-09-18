extends Area2D

var v_interractable_list = []
signal dialogue_activation(type: String)


func _ready():
	pass
	
func _process(delta):
	playerInteraction()
	pass

func playerInteraction():
	# Activates dialogue from interaction if the player's within an object
	if(Input.is_action_just_pressed("interact")):
		#If there's objects around to interact with
		if(v_interractable_list.size() != 0):
			if(GlobalScript.dialogue_open == false):
				#print_debug(v_interractable_list[0].get_node("Sprite2D/Interactable").getName())
				dialogue_activation.emit(v_interractable_list[0].get_node("Sprite2D/Interactable").getName())
		pass
	pass

func _on_area_entered(area: Area2D) -> void:
	if(area is Interractable):
		#print_debug("IN RANGE OF INTERACTABLE")
		area.setInteractable(true)
		v_interractable_list.append(area.getNode())
		pass
	pass # Replace with function body.


func _on_area_exited(area: Area2D) -> void:
	if(area is Interractable):
		#print_debug("NOT IN RANGE OF INTERACTABLE")
		area.setInteractable(false)
		var index = v_interractable_list.find(area.getNode())
		if index != -1:
			v_interractable_list.remove_at(index)
			pass
		pass
	pass # Replace with function body.
