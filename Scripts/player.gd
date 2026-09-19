extends CharacterBody2D
class_name Player

@onready var v_area = $Hitbox
@onready var v_camera = $Camera2D

const v_speed = 300
var v_current_direction = "none" 
var previous_end = "f"
var has_moved = false


func _ready():
	$AnimatedSprite2D.play("idle")
	

# Update Function
func _physics_process(delta):
	if(GlobalScript.can_move):
		playerMovement(delta)
		has_moved = true
	else:
		if(has_moved):
			playerAnimation(0)
			has_moved = false

func playerMovement(dt):
	
	if(Input.is_action_pressed("walk_right")):
		v_current_direction = "right"
		velocity.x = v_speed
	elif(Input.is_action_pressed("walk_left")):
		v_current_direction = "left"
		velocity.x = -v_speed
	else:
		velocity.x = 0
		
	if(Input.is_action_pressed("walk_down")):
		v_current_direction = "down"
		velocity.y = v_speed
	elif(Input.is_action_pressed("walk_up")):
		v_current_direction = "up"
		velocity.y = -v_speed
	else:
		velocity.y = 0
	
	#Change player animation
	if(velocity.y == 0 && velocity.x == 0):
		playerAnimation(0)
	else:
		playerAnimation(1)
	
	
	move_and_slide()
	pass
	
	
func playerAnimation(action):
	#"idle_1b
	#"walking_1b
	
	var direction = v_current_direction
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
	
	if(direction == "right"):
		animation_sprite.flip_h = false
	elif(direction == "left"):
		animation_sprite.flip_h = true
		
	if(direction == "down"):
		animation_name += "f"
		previous_end = "f"
	elif(direction == "up"):
		animation_name += "b"
		previous_end = "b"
	else:
		animation_name += previous_end
	animation_sprite.play(animation_name)

func changeCameraLimits(p_left:int,p_right: int, p_bottom: int, p_top: int):
	v_camera.set_limit(SIDE_LEFT,p_left)
	v_camera.set_limit(SIDE_RIGHT,p_right)
	v_camera.set_limit(SIDE_BOTTOM,p_bottom)
	v_camera.set_limit(SIDE_TOP,p_top)



func player():
	#Used for checking transitions between scenes
	pass
