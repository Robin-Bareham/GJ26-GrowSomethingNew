extends CanvasLayer

@onready var v_goal = $Goal
@onready var v_goal_CS2D = $Goal/Area2D/CollisionShape2D

@onready var v_rubbish_list = []

var v_goal_positions = [[401,361],[982,528],[523,792],[1611,354],[1400,811]]
var v_rubbish_icons = ["Rubbish01","Rubbish02","Rubbish03","Rubbish04"]


func _ready():
	#Gets all the rubbish into the array
	v_rubbish_list = get_tree().get_nodes_in_group("rubbish")

func resetMinigame(goalTexture: String):
	#Set goal's position 
	var goalTxt_location = "res://Assets/Minigame/" + goalTexture + ".png"
	v_goal.texture = load(goalTxt_location)
	#Change goal's Collision shape2D
	var goalCS2D_loc = "res://Assets/Styles/" + goalTexture + "CS2D.tres"
	v_goal_CS2D.shape = load(goalCS2D_loc)
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
		# MIGHT HAVE TO FIGURE OUT HOW TO CHANGE THE HITBOX BASED ON THE SPRITE CHOSEN
		
		pass
	#Change rubbish image as well, random between rubbish images.
	
	pass
