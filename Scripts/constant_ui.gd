extends CanvasLayer

@onready var bg = $bg
@onready var clock = $clock

@onready var lighting = get_tree().current_scene.get_node("Lighting")

var timer = 0
var timer_end
var second = 0
@onready var day_texture = load("res://Assets/Sprites/Clock00.png")
@onready var noon_texture = load("res://Assets/Sprites/Clock01.png")
@onready var evening_texture = load("res://Assets/Sprites/Clock02.png")

@onready var pileScene = load("res://Prefabs/InteractingObjects/Pile.tscn")
var d1_pilePOS = [[-1070,493],[-1175,-168],[-678,103],[-460,-284],[-151,-25],[15,-422],[607,-542],[466,-234],[530,468],[809,143],[971,-371],[1028,439],[1292,-55]]
var d1_pileOpts = ["G_Ash","G_Ash","G_Ash","G_Bark","G_Cloth"]
var d2_pilePOS = [[-1238,-139],[-631,153],[-418,590],[-294,-412],[216,-21],[466,-568],[759,526],[971,-157],[1386,274]]
var d2_pileOpts = ["G_Ash","G_Ash","G_Crown","G_Cloth"]
var d3_pilePOS = [[-749,245],[-507,-115],[137,-256],[450,189],[1031,28]]
var d3_pileOpts = ["G_Closed","G_Closed","G_Closed","G_Crown","G_Cloth"]
var d4_pilePOS = [[348,335]]
var d4_pileOpts = ["G_Final"]
var pile_list = []

var energy

func _process(delta):
	match GlobalScript.current_scene:
		"grove":
			progressTime(delta)
			#Reset and activates the timer
			if(GlobalScript.start_timer):
				resetTimer()
				GlobalScript.start_timer = false
				GlobalScript.timer_active = true
		"woods":
			clock.hide()

func progressTime(delta):
	if(GlobalScript.timer_active && !AllDia.dia_open):
				timer += 1 * delta
				if(timer >= timer_end):
					GlobalScript.day_over = true
					GlobalScript.activate_cutscene = true
				elif(timer >= (timer_end/3)*2):
					if(GlobalScript.day == 3):
						GlobalScript.day_over = true
						GlobalScript.activate_cutscene = true
					clock.texture = evening_texture
					lighting.showLight("evening")
				elif(timer >= (timer_end/3)):
					clock.texture = noon_texture
					lighting.showLight("noon")

## WHEN THE PLAYER ENTERS THE GROVE
func resetTimer():
	#When the player enters the grove.
	timer = 0
	clock.texture = day_texture
	clock.show()
	lighting.showLight("day")
	var current_list = []
	var current_pileOpts = []
	timer_end = GlobalScript.max_time
	match GlobalScript.day:
		1:
			GlobalScript.current_energy = GlobalScript.max_energy
			current_list = d1_pilePOS
			current_pileOpts = d1_pileOpts
		2:
			GlobalScript.current_energy = GlobalScript.max_energy - 20
			current_list = d2_pilePOS
			current_pileOpts = d2_pileOpts
		3:
			timer_end = GlobalScript.max_time
			GlobalScript.current_energy = GlobalScript.max_energy/2
			current_list = d3_pilePOS
			current_pileOpts = d3_pileOpts
		4:
			timer_end = GlobalScript.max_time * 30
			GlobalScript.current_energy = 10 #Can only do one search
			current_list = d4_pilePOS
			current_pileOpts = d4_pileOpts
			
	#Inits piles + whats in them.
	for i in current_list.size():
		var newPile = pileScene.instantiate()
		newPile.setPosition(current_list[i][0],current_list[i][1])
		newPile.setName(current_pileOpts[randi() % current_pileOpts.size()])
		newPile.setImage()
		get_tree().current_scene.get_node("Environment").add_child(newPile)
	#Update Pile Images
	#pile_list = get_tree().get_nodes_in_group("search")
	#for i in pile_list.size():
		#pile_list[i].setImage()
	
func changeBg(newBg: String):
	var temp = "res://Assets/Cutscenes/" + newBg + ".png"
	bg.texture = load(temp)

func hideBg():
	bg.hide()
func showBg():
	bg.show()	
