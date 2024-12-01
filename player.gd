extends CharacterBody2D

@export var move_speed: float = 100.0

var can_jump : bool = true
var can_sweep : bool = true
var can_stab : bool = true

func jump(event):
	if can_jump == true:
		var initial_player_position = self.position
		can_jump = false
		$AnimationPlayer.play("beta_jump")
		await $AnimationPlayer.animation_finished
		var overlap = $CollisionArea.get_overlapping_bodies()
		if overlap.size() > 1:
			self.position = initial_player_position
		can_jump = true

func sweep(event):
	if can_sweep == true:
		can_sweep = false
		can_stab = false
		get_node("Sweep").look_at(get_global_mouse_position())
		$AnimationPlayer.play("sweep_attack")
		await $AnimationPlayer.animation_finished
		can_sweep = true
		can_stab = true

func stab(event):
	if can_stab == true:
		can_stab = false
		can_sweep = false
		get_node("Stab").look_at(get_global_mouse_position())
		$AnimationPlayer.play("stab_attack")
		await $AnimationPlayer.animation_finished
		can_stab = true
		can_sweep = true

func _physics_process(delta):
	if self.velocity == Vector2(0,1) * move_speed or self.velocity == Vector2(0,-1) * move_speed:
		move_speed * 2
	velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down") * move_speed * Vector2(2,1)
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
