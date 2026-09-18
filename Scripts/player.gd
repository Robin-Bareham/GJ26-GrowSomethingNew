extends CharacterBody2D
class_name Player

@onready var v_area: Area2D = $Hitbox

const v_speed = 300
var v_current_direction = "none" 

func _ready():
	$AnimatedSprite2D.play("idle")

# Update Function
func _physics_process(delta):
	if(GlobalScript.can_move):
		playerMovement(delta)
	playerInputs()
	pass

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
	
func playerInputs():
	if(Input.is_action_pressed("interact")):
		pass
	pass
	
	
func playerAnimation(action):
	
	var direction = v_current_direction
	var animation_sprite = $AnimatedSprite2D
	
	if(action == 0):
		animation_sprite.play("idle")
	elif(action == 1):
		animation_sprite.play("walking")
		
	if(direction == "right"):
		animation_sprite.flip_h = false
		pass
	elif(direction == "left"):
		animation_sprite.flip_h = true
		pass
	elif(direction == "down"):
		pass	
	elif(direction == "up"):
		pass	
	
	
	pass
