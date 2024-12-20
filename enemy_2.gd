extends CharacterBody2D
class_name Enemy2

signal healthChanged
signal enemyDeath

#Add a functioning shooting state

@export var max_hp: int = 6
@export var hp: int = 6

func hit(damage_number: int):
	hp -= damage_number
	healthChanged.emit()
	if (hp <= 0):
		queue_free()
		enemyDeath.emit()
