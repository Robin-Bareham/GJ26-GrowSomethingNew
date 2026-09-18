extends CanvasLayer

@onready var label = $Label

var timer = 0
var second = 0

func _process(delta):
	match GlobalScript.current_scene:
		"grove":
			timer += 1 * delta
			if(timer >= 30):
				toWoods()
			elif(timer >= 20):
				print_debug("EVENING")
			elif(timer >= 10):
				print_debug("NOON")
			
			if(GlobalScript.energy <= 0):
				toWoods()
			#Visual change of shaders???
			second = int(timer)
			label.text = str(second)

func resetTimer():
	timer = 0
	
func toWoods():
	GlobalScript.minigame_active = false
	GlobalScript.activating_minigame = false
	GlobalScript.transition_scene = true
	GlobalScript.next_scene = "woods"
	GlobalScript.change_scene()
	
