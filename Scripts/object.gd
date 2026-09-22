extends Node2D

@export var v_object_name: String = "NULL"
@export var v_object_node: Node2D
@onready var collision = $StaticBody2D/CollisionShape2D
@onready var hitbox = $StaticBody2D/Interact/CollisionShape2D

var v_object_interactable = false
var v_been_searched = false
var v_visible = true

func _ready():
	if(v_object_name == "Blindfold" && GlobalScript.items["Blindfold"]):
		setVisib(false)
	else:
		setVisib(true)

func getName():
	return v_object_name

func setName(new_name: String):
	v_object_name = new_name

func setPosition(x: int,y:int):
	position.x = x
	position.y = y

func getNode():
	return v_object_node

func setInteractable(status: bool):
	v_object_interactable = status

func setVisib(type: bool):
	if(type):
		v_object_node.show()
		v_visible = true
		collision.set_deferred("disabled",false)
		hitbox.set_deferred("disabled",false)
	else:
		v_object_node.hide()
		v_visible = false
		collision.set_deferred("disabled",true)
		hitbox.set_deferred("disabled",true)

func getVisib():
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
