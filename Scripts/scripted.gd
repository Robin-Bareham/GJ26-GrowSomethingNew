extends Area2D

@export var event_name: String
@export var instant: bool
@export var starting_bg: String

func getName():
	return event_name

func getInst():
	return instant

func getBg():
	return starting_bg
