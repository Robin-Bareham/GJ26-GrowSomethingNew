extends CanvasLayer

@onready var label = $Label
@onready var bg = $bg

var timer = 0
var timer_end
var second = 0

var energy

func _process(delta):
	match GlobalScript.current_scene:
		"grove":
			#If the timer is active, start day.
			if(GlobalScript.timer_active):
				timer += 1 * delta
				if(timer >= timer_end):
					GlobalScript.day_over = true
				elif(timer >= (timer_end/3)*2):
					pass
				elif(timer >= (timer_end/3)):
					pass
				#Visual change of shaders???
				second = int(timer)
				label.text = str(second)
			#Reset and activates the timer
			if(GlobalScript.start_timer):
				resetTimer()
				GlobalScript.start_timer = false
				GlobalScript.timer_active = true

func resetTimer():
	#When the player enters the grove.
	timer = 0
	if(GlobalScript.day == 1):
		timer_end = GlobalScript.max_time
		GlobalScript.current_energy = GlobalScript.max_energy
	elif(GlobalScript.day == 2):
		timer_end = GlobalScript.max_time
		GlobalScript.current_energy = GlobalScript.max_energy - 20
	elif(GlobalScript.day == 3):
		timer_end = GlobalScript.max_time/2
		GlobalScript.current_energy = GlobalScript.max_energy/2
	elif(GlobalScript.day == 4):
		timer_end = GlobalScript.max_time/2
		GlobalScript.current_energy = 10 #Can only do one search

func changeBg(newBg: String):
	var temp = "res://Assets/TempAssets/" + newBg + ".png"
	bg.texture = load(temp)

func hideBg():
	bg.hide()
func showBg():
	bg.show()
