extends Node2D

@export var type: String
@export var nextImg: String
@onready var sprite = $StaticBody2D/Sprite2D

func _ready():
	reloadTextures()

func reloadTextures():
	var texture_location
	if(GlobalScript.day >= 3):
		texture_location = "res://Assets/Sprites/" + nextImg + ".png"
	else:
		texture_location = "res://Assets/Sprites/" + type + ".png"
	sprite.texture = load(texture_location)
