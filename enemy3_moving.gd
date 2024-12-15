extends State
class_name Enemy3_Move

@export var chase_speed: float = 120.0
var target: CharacterBody2D
var attack : Area2D
var leave_attack : Array
var attacking_state : State
var choose_direction : bool = true
var random : Vector2
var target_initial_position : Vector2

func initialize():
	attack = body.get_node("Attack")
	attacking_state = get_parent().get_node("Attacking")

func process_state(delta: float):
	#print("Attacking")
	leave_attack = attack.get_overlapping_bodies()
	
	if (not leave_attack.is_empty()):
		if choose_direction == true:
			random = Vector2((randf()*50 - 25),(randf()*50 - 25))
			target_initial_position = (target.position - body.position).normalized()
			choose_direction = false
		body.velocity = (target_initial_position + random) * chase_speed *Vector2(1,1) 
		body.move_and_slide()
		attacking_state.target = target
		change_state.emit(attacking_state, "Attacking")
		choose_direction = true
	
