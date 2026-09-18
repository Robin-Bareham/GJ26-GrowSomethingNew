extends Sprite2D

#From tutorial: https://youtu.be/3ThOxFZcie0?si=0gFSxajLTfjF_iE2

var v_dragging = false
var v_offset = Vector2(0,0)

func _process(delta):
	if(v_dragging):
		position = get_global_mouse_position() - v_offset

func _on_button_button_down() -> void:
	v_dragging = true
	v_offset = get_global_mouse_position() - global_position


func _on_button_button_up() -> void:
	v_dragging = false


func _on_button_mouse_entered() -> void:
	pass #Highlight object


func _on_button_mouse_exited() -> void:
	pass #Unhighlight object
