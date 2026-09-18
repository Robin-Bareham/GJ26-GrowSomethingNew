extends CanvasLayer

@onready var v_goal = $Goal

@onready var v_rubbish_list = []

var v_goal_positions = [[401,361],[982,528],[523,792],[1611,354],[1400,811]]
var v_rubbish_icons = ["temp_leaf1","temp_leaf2","temp_leaf3"]


func _ready():
	#Gets all the rubbish into the array
	v_rubbish_list = get_tree().get_nodes_in_group("rubbish")

func resetMinigame(goalTexture: String):
	#Set goal's position 
	var goalTxt_location = "res://Assets/TempAssets/" + goalTexture + ".png"
	v_goal.texture = load(goalTxt_location)
	v_goal.position.x = v_goal_positions[randi() % v_goal_positions.size()][0]
	v_goal.position.y = v_goal_positions[randi() % v_goal_positions.size()][1]
	#Run through list, set their position based on goal's position
	for i in v_rubbish_list.size():
		#Adjust position around goal
		v_rubbish_list[i].position.x = v_goal.position.x + randi_range(-250,250)
		v_rubbish_list[i].position.y = v_goal.position.y + randi_range(-250,250)
		#Change sprite picture to random rubish
		var texture_location = "res://Assets/TempAssets/" + v_rubbish_icons[randi() % v_rubbish_list.size()] + ".png"
		v_rubbish_list[i].texture = load(texture_location)
		
		# MIGHT HAVE TO FIGURE OUT HOW TO CHANGE THE HITBOX BASED ON THE SPRITE CHOSEN
		
		pass
	#Change rubbish image as well, random between rubbish images.
	
	pass
