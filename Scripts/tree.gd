extends Node2D

@export var type: String
@onready var sprite = $StaticBody2D/Sprite2D

func _ready():
	var texture_location = "res://Assets/Sprites/" + type + ".png"
	sprite.texture = load(texture_location)
