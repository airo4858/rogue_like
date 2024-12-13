extends CharacterBody2D

@export var max_hp : int = 10
@export var item : Resource

var can_jump : bool = true
var can_sweep : bool = true
var can_stab : bool = true
var targets : Array
var knockback : Vector2 = Vector2(-1,-1)

signal switch_stage

func jump(event):
	if can_jump == true:
		var initial_player_position = self.position
		can_jump = false
		can_sweep = false
		can_stab = false
		$AnimationPlayer.play("beta_jump")
		await $AnimationPlayer.animation_finished
		var overlap = $ItemPickupArea.get_overlapping_bodies()
		if StageManager.can_switch_stage == true:
			for i in overlap:
				if i.is_in_group("OutOfBounds"):
					switch_stage.emit()
		if overlap.size() >= 1:
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
		if StageManager.extra_sweep == 1:
			$AnimationPlayer.play("sweep_attack")
			await $AnimationPlayer.animation_finished
		elif StageManager.extra_sweep >= 2:
			$AnimationPlayer.play("extra_sweep_attack")
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
		if StageManager.extra_stab == 1:
			$AnimationPlayer.play("stab_attack")
			await $AnimationPlayer.animation_finished
		elif StageManager.extra_stab >= 2:
			$AnimationPlayer.play("extra_stab_attack")
			await $AnimationPlayer.animation_finished
		can_stab = true
		can_sweep = true
		can_jump = true
		
func hurt(damage_number : int):
	StageManager.hp -= damage_number
	
	get_tree().get_root().get_node( StageManager.current_stage +  "/UI").get_hurt(1)
	if (StageManager.hp <= 0):
		self.visible = false
		get_tree().get_root().get_node( StageManager.current_stage +  "/UI/GameOver").visible = true
		get_tree().paused = true

func _physics_process(delta):
	velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down") * StageManager.move_speed * Vector2(2,1)
	if velocity == Vector2(0,100) or velocity == Vector2(0,-100):
		velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down") * StageManager.move_speed * Vector2(2,1.5)
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
	body.hit(StageManager.stab_damage)
	
func _on_sweep_hurtbox_body_entered(body: Node2D) -> void:
	body.hit(StageManager.sweep_damage)
	StageManager.just_hit = true
	body.velocity = (self.position - body.position).normalized() * 300 * knockback
	body.move_and_slide()
	knockback = lerp(knockback, Vector2.ZERO, 0.1)
	await lerp(knockback, Vector2.ZERO, 0.1)
	StageManager.just_hit = false

#Item Pickup Code
func _on_collision_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Item"):
		body.pickup()
		print("PICKUP")
