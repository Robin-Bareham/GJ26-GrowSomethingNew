extends Sprite2D

@onready var v_area2d = $Area2D


func _on_button_button_down() -> void:
	#If the object has nothing above it
	if(v_area2d.get_overlapping_areas().size() == 0):
		GlobalScript.activating_minigame = true

func _on_button_button_up() -> void:
	pass # Replace with function body.


func _on_button_mouse_entered() -> void:
	pass # Replace with function body.


func _on_button_mouse_exited() -> void:
	pass # Replace with function body.
