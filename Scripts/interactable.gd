extends Area2D
class_name Interractable

@export var v_object_name: String = "NULL"
@export var v_object_node: Node2D
var v_object_interactable = false

func getName():
	return v_object_name

func getNode():
	return v_object_node
	
func setInteractable(status: bool):
	v_object_interactable = status
