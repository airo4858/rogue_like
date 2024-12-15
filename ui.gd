extends CanvasLayer

var health : int = StageManager.hp 
var setup : bool = true

func get_hurt(num : int):
	health -= num
	$Health.text = "Health: " + str(health)
	
func gain_health(num : int):
	health += num
	$Health.text = "Health: " + str(health)
	
func _physics_process(delta: float):
	if setup == true:
		$Health.text = "Health: " + str(StageManager.hp)
		$StageTracker.text = str(StageManager.current_stage)
		setup = false
	if StageManager.current_stage == "Stage2" or StageManager.current_stage == "Stage3":
		$StartScreen.visible = false
