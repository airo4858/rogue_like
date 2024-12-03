extends State
class_name Enemy1_Attack

var target: CharacterBody2D
var attack : Area2D
var leave_attack : Array
var chasing_state : State
var attack_animation : AnimationPlayer
var can_attack : bool = true

func initialize():
	attack = body.get_node("Attack")
	chasing_state = get_parent().get_node("Chasing")
	attack_animation = body.get_node("AnimationEnemy")
	
func process_state(delta: float):
	#print("Attacking")
	leave_attack = attack.get_overlapping_bodies()
	
	if (not leave_attack.is_empty()):
		if (can_attack == true):
			can_attack = false
			body.get_node("AttackAnimation").look_at(target.position)
			attack_animation.play("enemy1_attack")
			await attack_animation.animation_finished
			can_attack = true
	
	if (leave_attack.is_empty()):
		if (can_attack == true):
			change_state.emit(chasing_state, "Chasing")
