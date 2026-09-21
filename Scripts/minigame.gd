extends CanvasLayer

@onready var v_goal = $Goal
@onready var v_goal_CS2D = $Goal/Area2D/CollisionShape2D

@onready var v_overlay = $overlay
@onready var v_blur = $blurrect

@onready var v_rubbish_list = []

@onready var v_audio = GlobalScript.get_audio_player()
@onready var s_leaf = load("res://Audio/SFX_Leaves.mp3")

var v_goal_positions = [[401,361],[982,535],[523,792],[1611,354],[1400,811]]
var v_rubbish_icons = ["Rubbish01","Rubbish02","Rubbish03","Rubbish04"]


func _ready():
	#Gets all the rubbish into the array
	v_rubbish_list = get_tree().get_nodes_in_group("rubbish")

func resetMinigame(goalTexture: String):
	if(!v_audio.is_playing()):
		v_audio.stream = s_leaf
		v_audio.play()
	changeShaders()
	#Set goal's position 
	var goalTxt_location = "res://Assets/Minigame/" + goalTexture + ".png"
	v_goal.texture = load(goalTxt_location)
	#Change goal's Collision shape2D
	var goalCS2D_loc = "res://Assets/Styles/" + goalTexture + "CS2D.tres"
	v_goal_CS2D.shape = load(goalCS2D_loc)
	if(GlobalScript.day == 4):
		v_goal.position.x = v_goal_positions[1][0]
		v_goal.position.y = v_goal_positions[1][1]
	else:
		v_goal.position.x = v_goal_positions[randi() % v_goal_positions.size()][0]
		v_goal.position.y = v_goal_positions[randi() % v_goal_positions.size()][1]
	#Run through list, set their position based on goal's position
	for i in v_rubbish_list.size():
		#Adjust position around goal
		v_rubbish_list[i].position.x = v_goal.position.x + randi_range(-250,250)
		v_rubbish_list[i].position.y = v_goal.position.y + randi_range(-250,250)
		#Change sprite picture to random rubish
		var rand_index = randi() % v_rubbish_list.size()
		var texture_location = "res://Assets/Minigame/" + v_rubbish_icons[rand_index] + ".png"
		v_rubbish_list[i].texture = load(texture_location)
		var cs2d_loc = "res://Assets/Styles/" + v_rubbish_icons[rand_index] + "CS2D.tres"
		v_rubbish_list[i].getCS2D().shape = load(cs2d_loc)


func changeShaders():
	var shader_loc = ""
	if(GlobalScript.day == 1):
		shader_loc = "res://Assets/Shaders/S_Highlight.gdshader"
		v_overlay.color = Color(0,0,0,0.80) 
		v_blur.set_instance_shader_parameter("blur_amount", 1.5)
	elif(GlobalScript.day == 2):
		shader_loc = "res://Assets/Shaders/S_Highlight2.gdshader"
		v_overlay.color = Color(0,0,0,0.50)
		v_blur.set_instance_shader_parameter("blur_amount", 1.25)
	elif(GlobalScript.day == 3):
		shader_loc = "res://Assets/Shaders/S_Distort.gdshader"
		v_overlay.color = Color(0,0,0,0.25)
		v_blur.set_instance_shader_parameter("blur_amount", 1.0)
		#Doubles, S_blur, No darkness overlay
	elif(GlobalScript.day == 4):
		shader_loc = "res://Assets/Shaders/S_Distort2.gdshader"
		v_overlay.color = Color(0,0,0,0)
		v_blur.set_instance_shader_parameter("blur_amount", 0.5)
		#Slight distortion, no S_blur, no darkness.
		
	iterateShaders(shader_loc)
	print_debug("BLUR AMOUNT:")
	print_debug(v_blur.get_instance_shader_parameter("blur_amount"))
	
func iterateShaders(type: String):
	v_goal.material.shader = load(type)
	for i in v_rubbish_list.size():
		v_rubbish_list[i].material.shader = load(type)
