extends State
class_name Enemy3_Chasing

@export var chase_speed: float = 120.0
var target: CharacterBody2D
var moving_state : State
var idle_state : State
var hitbox : Area2D
var attack : Area2D
var detection : Area2D
var potential_attack : Array
var leave_detection : Array

func initialize():
	hitbox = body.get_node("Hitbox")
	attack = body.get_node("Attack")
	detection = body.get_node("Detection")
	moving_state = get_parent().get_node("Move")
	idle_state = get_parent().get_node("Idle")

func process_state(delta: float):
	#print("Chasing")
	body.velocity = (target.position - body.position).normalized() * chase_speed
	body.move_and_slide()
	var hit_targets = hitbox.get_overlapping_bodies()
	
	var direction = (target.position - body.position).normalized()
	var angle = rad_to_deg(body.velocity.angle()) + 180
	
	leave_detection = detection.get_overlapping_bodies()
	potential_attack = attack.get_overlapping_bodies()
	
	if (leave_detection.is_empty()):
		change_state.emit(idle_state, "Idle")
	
	if (not potential_attack.is_empty()):
		moving_state.target = (potential_attack[0] as CharacterBody2D)
		change_state.emit(moving_state, "Move")
	
	#if (not hit_targets.is_empty()):
		#get_tree().get_root().get_node("Main/Player").hurt(1)
		#body.queue_free()
