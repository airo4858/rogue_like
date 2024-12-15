extends State
class_name Enemy3_Attack

@export var chase_speed: float = 300.0
var target : CharacterBody2D
var attack : Area2D
var leave_attack : Array
var idle_state : State
var attack_animation : AnimationPlayer
var can_attack : bool = true
var choose_direction : bool = true
var target_initial_position : Vector2

func initialize():
	attack = body.get_node("Attack")
	idle_state = get_parent().get_node("Idle")
	attack_animation = body.get_node("AnimationEnemy")

func process_state(delta: float):
	#print("Attacking")
	leave_attack = attack.get_overlapping_bodies()
	
	body.move_and_slide()
	if (can_attack == true):
		can_attack = false
		body.velocity = Vector2(0,0)
		var initial_enemy_position = body.position
		await get_tree().create_timer(2.5).timeout
		body.get_node("AttackAnimation").look_at(target.position)
		attack_animation.play("enemy3_attack")
		if choose_direction == true:
			target_initial_position = (target.position - body.position).normalized()
			choose_direction = false
		body.velocity = target_initial_position * chase_speed
		body.move_and_slide()
		await attack_animation.animation_finished
		var overlap = body.get_node("Hitbox").get_overlapping_bodies()
		if overlap.size() >= 1:
			body.position = initial_enemy_position
		can_attack = true
		choose_direction = true
		change_state.emit(idle_state, "Idle")
