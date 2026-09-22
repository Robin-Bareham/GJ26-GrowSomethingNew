extends Sprite2D

#From tutorial: https://youtu.be/3ThOxFZcie0?si=0gFSxajLTfjF_iE2
@onready var v_cs2d = $Area2D/CollisionShape2D
@onready var v_audio = GlobalScript.get_audio_player()

@onready var s_drag_list = [load("res://Audio/SFX_Drag01.mp3"),load("res://Audio/SFX_Drag02.mp3"),load("res://Audio/SFX_Drag03.mp3"),load("res://Audio/SFX_Drag04.mp3")]


var v_dragging = false
var v_offset = Vector2(0,0)

func _process(delta):
	if(v_dragging && !AllDia.dia_open):
		position = get_global_mouse_position() - v_offset

func getCS2D():
	return v_cs2d

func _on_button_button_down() -> void:
	v_dragging = true
	v_offset = get_global_mouse_position() - global_position
	if(!v_audio.is_playing()):
		v_audio.stream = s_drag_list[randi() % s_drag_list.size()]
		v_audio.play()


func _on_button_button_up() -> void:
	v_dragging = false
	


func _on_button_mouse_entered() -> void:
	material.set_shader_parameter("highlighted", true)


func _on_button_mouse_exited() -> void:
	material.set_shader_parameter("highlighted", false)
