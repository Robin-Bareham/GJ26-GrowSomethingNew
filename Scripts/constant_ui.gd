extends CanvasLayer

@onready var label = $Label

var timer = 0
var second = 0

func _process(delta):
	match GlobalScript.current_scene:
		"grove":
			timer += 1 * delta
			if(timer >= 10):
				transWoods()
			elif(timer >= 20):
				print_debug("EVENING")
			elif(timer >= 10):
				print_debug("NOON")
			
			second = int(timer)
			label.text = str(second)

func resetTimer():
	timer = 0
	
func transWoods():
	print_debug("Transitioning")
	GlobalScript.transition_scene = true
	GlobalScript.next_scene = "woods"
	GlobalScript.change_scene()
	
