extends CharacterBody2D
class_name Player

@onready var v_area = $Hitbox
@onready var v_camera = $Camera2D
@onready var v_audio = $Interaction_HB/AudioStreamPlayer2D
@onready var v_bg_mus = $BackgroundMus

@onready var s_feet = [load("res://Audio/SFX_Foot01.mp3"),load("res://Audio/SFX_Foot02.mp3"),load("res://Audio/SFX_Foot03.mp3"),load("res://Audio/SFX_Foot04.mp3")]

@onready var s_footstep = load("res://Audio/SFX_FootSingle.mp3")
const v_speed = 300
var y_current_direction = "none" 
var x_current_direction = "none"
var previous_end = "f"
var has_moved = false

var new_area = true

var lr_fix = "right"

func _ready():
	$AnimatedSprite2D.play("idle")
	if(GlobalScript.current_scene == "grove"):
		v_bg_mus.play()

# Update Function
func _physics_process(delta):
	if(GlobalScript.currentState == GlobalScript.gameState.GAME) :
		if(GlobalScript.can_move && !GlobalScript.minigame_active):
			playerMovement(delta)
			has_moved = true
		else:
			if(has_moved):
				playerAnimation(0)
				has_moved = false

func playerMovement(dt):
	
	# Handles movement
	if(Input.is_action_pressed("walk_right")):
		x_current_direction = "right"
		velocity.x = v_speed
	elif(Input.is_action_pressed("walk_left")):
		x_current_direction = "left"
		velocity.x = -v_speed
	else:
		velocity.x = 0
		
	if(Input.is_action_pressed("walk_down")):
		y_current_direction = "down"
		velocity.y = v_speed
	elif(Input.is_action_pressed("walk_up")):
		y_current_direction = "up"
		velocity.y = -v_speed
	else:
		velocity.y = 0
	#Change player animation
	if(velocity.y == 0 && velocity.x == 0):
		playerAnimation(0)
		if(v_audio.is_playing()):
			v_audio.stop()
	else:
		playerAnimation(1)
		if(!v_audio.is_playing()):
			v_audio.stream = s_feet[randi() % s_feet.size()]
			v_audio.play()
	
	
	move_and_slide()
	pass
	
	
func playerAnimation(action):
	#"idle_1b
	#"walking_1b
	var animation_sprite = $AnimatedSprite2D
	var animation_name = ""
	
	if(action == 0):
		animation_name += "idle_"
	elif(action == 1):
		animation_name += "walking_"
	if(GlobalScript.day == 1 && !GlobalScript.items["Blindfold"]):
		animation_name += "e"
	else:
		animation_name += str(GlobalScript.day)
	
	if(x_current_direction == "right"):
		animation_sprite.flip_h = false
	elif(x_current_direction == "left"):
		animation_sprite.flip_h = true
		
	if(y_current_direction == "down"):
		animation_name += "f"
		previous_end = "f"
	elif(y_current_direction == "up"):
		animation_name += "b"
		previous_end = "b"
	else:
		animation_name += "f"
	animation_sprite.play(animation_name)

func changeCameraLimits(p_left:int,p_right: int, p_bottom: int, p_top: int):
	v_camera.set_limit(SIDE_LEFT,p_left)
	v_camera.set_limit(SIDE_RIGHT,p_right)
	v_camera.set_limit(SIDE_BOTTOM,p_bottom)
	v_camera.set_limit(SIDE_TOP,p_top)
func player():
	#Used for checking transitions between scenes
	pass
