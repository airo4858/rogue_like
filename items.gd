extends CharacterBody2D

var item_number : int
var has_pickup : bool = false
#@export var player_character : Resource

func pick_item():
	item_number = randf()*3 + 1
	if (item_number == 1):
		$AnimationItem.play("item_1_beta")
	elif (item_number == 2):
		$AnimationItem.play("item_2_beta")
	elif (item_number == 3):
		$AnimationItem.play("item_3_beta")

func pickup(player_character: CharacterBody2D):
	if (item_number == 1):
		player_character.sweep_damage += 1
		player_character.extra_sweep += 1
	elif (item_number == 2):
		player_character.stab_damage += 1
		player_character.extra_stab += 1
	elif (item_number == 3):
		player_character.hp += 2
		get_tree().get_root().get_node("Stage1/UI").gain_health(2)
	has_pickup = true
	queue_free()
