extends Node2D

@export var enemy1 : CharacterBody2D
@export var enemy2 : CharacterBody2D
@export var enemy3 : CharacterBody2D
@export var item : Resource 
@export var enemy_count : int = 3

var spawn_item : bool = true
var newest_item : CharacterBody2D

func _ready():
	enemy1.enemyDeath.connect(death_counter)
	enemy2.enemyDeath.connect(death_counter)
	enemy3.enemyDeath.connect(death_counter)

func death_counter():
	enemy_count -= 1

func end_stage(item : CharacterBody2D):
	print(item.has_pickup)
	if item.has_pickup == true:
		print("END STAGE")
		pass

func _physics_process(delta: float):
	if(enemy_count <= 0):
		if spawn_item == true:
			var new_item = item.instantiate()
			get_parent().add_child(new_item)
			new_item.position = $ItemSpawnPoint.global_position
			new_item.pick_item()
			spawn_item = false
			newest_item = new_item
		end_stage(newest_item)
