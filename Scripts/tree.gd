extends Node2D

@export var tree_type: String
@onready var tree_sprite = $StaticBody2D/Sprite2D

func _ready():
	var texture_location = "res://Assets/Sprites/" + tree_type + ".png"
	tree_sprite.texture = load(texture_location)
