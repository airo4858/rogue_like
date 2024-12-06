extends Node2D

@export var enemy1 : CharacterBody2D
@export var enemy2 : CharacterBody2D
@export var enemy3 : CharacterBody2D
@export var item : Resource 
@export var enemy_count : int = 3

var spawn_item : bool = true

func _ready():
	enemy1.enemyDeath.connect(death_counter)
	enemy2.enemyDeath.connect(death_counter)
	enemy3.enemyDeath.connect(death_counter)

func death_counter():
	enemy_count -= 1

func _physics_process(delta: float):
	if(enemy_count <= 0):
		if spawn_item == true:
			spawn_item = false
			var new_item = item.instantiate()
			get_parent().add_child(new_item)
			new_item.position = $ItemSpawnPoint.global_position
			new_item.pick_item()
