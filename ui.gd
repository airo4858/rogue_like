extends CanvasLayer

var health : int = 3

func get_hurt(num : int):
	health -= num
	$Health.text = "Health: " + str(health)
	
func gain_health(num : int):
	health += num
	$Health.text = "Health: " + str(health)
