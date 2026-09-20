extends Node2D

@export var v_object_name: String = "NULL"
@export var v_object_node: Node2D

var v_object_interactable = false

func getName():
	return v_object_name

func setName(new_name: String):
	v_object_name = new_name
	
func getNode():
	return v_object_node

func setInteractable(status: bool):
	v_object_interactable = status

func setImage():
	var texture_location = "res://Assets/Sprites/RubbishPile_" + v_object_name + ".png"
	if(v_object_name == "G_Final"):
		texture_location = "res://Assets/Sprites/RubbishPile_G_Closed.png"
	$StaticBody2D/Sprite2D.texture = load(texture_location)
