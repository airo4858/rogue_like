extends Node2D

@export var enemy1 : CharacterBody2D
@export var enemy2 : CharacterBody2D
@export var enemy3 : CharacterBody2D
@export var enemy4 : CharacterBody2D
@export var enemy5 : CharacterBody2D
@export var item : Resource 
@export var enemy_count : int

var spawn_item : bool = true
var newest_item : CharacterBody2D
@onready var ui_animation : AnimationPlayer = get_node("UI/AnimationUI")

func _ready():
	enemy1.enemyDeath.connect(death_counter)
	enemy2.enemyDeath.connect(death_counter)
	enemy3.enemyDeath.connect(death_counter)
	enemy4.enemyDeath.connect(death_counter)
	enemy5.enemyDeath.connect(death_counter)

func death_counter():
	enemy_count -= 1

func end_stage():
	print("END STAGE")
	ui_animation.play("EndGame")
	await ui_animation.animation_finished
	get_tree().paused = true
	
func switch_stage():
	StageManager.current_stage = "Stage4"

func _physics_process(delta: float):
	StageManager.current_stage = "Stage3"
	if(enemy_count <= 0):
		if spawn_item == true:
			var new_item = item.instantiate()
			get_parent().add_child(new_item)
			new_item.position = $ItemSpawnPoint.global_position
			new_item.pick_item()
			spawn_item = false
			newest_item = new_item
			newest_item.on_pick_up.connect(end_stage)
