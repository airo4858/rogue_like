extends CharacterBody2D

@export var move_speed: float = 100.0

@export var max_hp : int = 3
@export var hp: int = max_hp
@export var item : Resource
#Create a variable keeping track of which stage and have that correlate to the hurt function
var stab_damage: int = 1
var sweep_damage: int = 2

var can_jump : bool = true
var can_sweep : bool = true
var can_stab : bool = true
var targets : Array

func jump(event):
	if can_jump == true:
		var initial_player_position = self.position
		can_jump = false
		can_sweep = false
		can_stab = false
		$AnimationPlayer.play("beta_jump")
		await $AnimationPlayer.animation_finished
		var overlap = $CollisionArea.get_overlapping_bodies()
		if overlap.size() > 1:
			self.position = initial_player_position
		can_jump = true
		can_sweep = true
		can_stab = true

func sweep(event):
	if can_sweep == true:
		can_sweep = false
		can_stab = false
		can_jump = false
		get_node("Sweep").look_at(get_global_mouse_position())
		$AnimationPlayer.play("sweep_attack")
		await $AnimationPlayer.animation_finished
		can_sweep = true
		can_stab = true
		can_jump = true

func stab(event):
	if can_stab == true:
		can_stab = false
		can_sweep = false
		can_jump = false
		get_node("Stab").look_at(get_global_mouse_position())
		$AnimationPlayer.play("stab_attack")
		await $AnimationPlayer.animation_finished
		can_stab = true
		can_sweep = true
		can_jump = true
		
func hurt(damage_number : int):
	hp -= damage_number
	
	get_tree().get_root().get_node("Stage1/UI").get_hurt(1)
	if (hp <= 0):
		self.visible = false
		get_tree().paused = true

func _physics_process(delta):
	velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down") * move_speed * Vector2(2,1)
	if velocity == Vector2(0,100) or velocity == Vector2(0,-100):
		velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down") * move_speed * Vector2(2,1.5)
	move_and_slide()
	
	if (Input.is_action_pressed("jump")):
		jump("jump")
		#print("JUMP!")
		
	if (Input.is_action_pressed("stab")):
		stab("stab")
		#print("STAB")
		
	if (Input.is_action_pressed("sweep")):
		sweep("sweep")
		#print("SWEEP")

func _on_stab_hurtbox_body_entered(body: Node2D) -> void:
	body.hit(stab_damage)
	
func _on_sweep_hurtbox_body_entered(body: Node2D) -> void:
	body.hit(sweep_damage)

#Item Pickup Code
func _on_collision_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Item"):
		print("PICKUP")
		body.pickup(self)
