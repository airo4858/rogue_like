extends Node2D

@export var player : CharacterBody2D
@export var enemy1 : CharacterBody2D
@export var enemy2 : CharacterBody2D
@export var enemy3 : CharacterBody2D
@export var enemy4 : CharacterBody2D
@export var enemy5 : CharacterBody2D
@export var item : Resource 
@export var enemy_count : int

var spawn_item : bool = true
var newest_item : CharacterBody2D
var next_scene = preload("res://stage_3.tscn").instantiate()
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
	get_tree().get_root().get_node( StageManager.current_stage +  "/UI/EndStageHint").visible = true
	StageManager.can_switch_stage = true
	player.switch_stage.connect(switch_stage)
	
func switch_stage():
	ui_animation.play("ScreenTransitionStart")
	await ui_animation.animation_finished
	queue_free()
	get_tree().get_root().add_child(next_scene)
	ui_animation.play("ScreenTransitionEnd")
	await ui_animation.animation_finished
	StageManager.current_stage = "Stage3"
	StageManager.can_switch_stage = false

func _physics_process(delta: float):
	StageManager.current_stage = "Stage2"
	if(enemy_count <= 0):
		if spawn_item == true:
			var new_item = item.instantiate()
			get_parent().add_child(new_item)
			new_item.position = $ItemSpawnPoint.global_position
			new_item.pick_item()
			spawn_item = false
			newest_item = new_item
			newest_item.on_pick_up.connect(end_stage)