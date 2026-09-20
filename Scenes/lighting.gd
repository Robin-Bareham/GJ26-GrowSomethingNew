extends Node2D

@onready var day_lighting =$Day
@onready var noon_lighting = $Noon
@onready var evening_lighting = $Evening
@onready var directional_light = $DirectionalLight2D

func showLight(time: String):
	match time:
		"day":
			day_lighting.show()
			directional_light.show()
			noon_lighting.hide()
			evening_lighting.hide()
		"noon":
			noon_lighting.show()
			directional_light.show()
			day_lighting.hide()
			evening_lighting.hide()
		"evening":
			evening_lighting.show()
			directional_light.hide()
			noon_lighting.hide()
			day_lighting.hide()
