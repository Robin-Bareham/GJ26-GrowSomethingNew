extends Node2D

@export var v_object_name: String = "NULL"
@export var v_object_node: Node2D

var v_object_interactable = false
var v_been_searched = false
var v_visible = true

func getName():
	return v_object_name

func setName(new_name: String):
	v_object_name = new_name
	
func getNode():
	return v_object_node

func setInteractable(status: bool):
	v_object_interactable = status

func setVisib(type: bool):
	if(type):
		v_object_node.show()
		v_visible = true
	else:
		v_object_node.hide()
		v_visible = false

func getVisib():
	print_debug(v_visible)
	return v_visible

func setImage():
	var texture_location
	if(v_been_searched):
		texture_location = "res://Assets/Sprites/RubbishPile_Empty.png"
	else:
		texture_location = "res://Assets/Sprites/RubbishPile_" + v_object_name + ".png"
		if(v_object_name == "G_Final"):
			texture_location = "res://Assets/Sprites/RubbishPile_G_Closed.png"
	$StaticBody2D/Sprite2D.texture = load(texture_location)
