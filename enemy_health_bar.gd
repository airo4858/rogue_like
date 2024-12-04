extends ProgressBar

@export var enemy : CharacterBody2D

func _ready():
	enemy.healthChanged.connect(update)
	update()

func update():
	value = enemy.hp * 10 / enemy.max_hp
