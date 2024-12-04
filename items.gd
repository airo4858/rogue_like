extends CharacterBody2D

var item_number : int

func pick_item():
	item_number = randf()*3 + 1
	if (item_number == 1):
		$AnimationItem.play("item_1_beta")
	elif (item_number == 2):
		$AnimationItem.play("item_2_beta")
	elif (item_number == 3):
		$AnimationItem.play("item_3_beta")
