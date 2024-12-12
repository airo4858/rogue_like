extends CharacterBody2D

var item_number : int
var has_pickup : bool = false
#@export var player_character : Resource

signal on_pick_up

func pick_item():
	item_number = randf()*3 + 1
	if (item_number == 1):
		$AnimationItem.play("item_1_beta")
	elif (item_number == 2):
		$AnimationItem.play("item_2_beta")
	elif (item_number == 3):
		$AnimationItem.play("item_3_beta")

func pickup():
	if (item_number == 1):
		StageManager.sweep_damage += 1
		StageManager.extra_sweep += 1
	elif (item_number == 2):
		StageManager.stab_damage += 1
		StageManager.extra_stab += 1
	elif (item_number == 3):
		StageManager.hp += 2
		get_tree().get_root().get_node("Stage1/UI").gain_health(2)
	has_pickup = true
	on_pick_up.emit()
	queue_free()
