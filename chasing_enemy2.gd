extends State
class_name Enemy2_Chasing

@export var chase_speed: float = 80.0
var target: CharacterBody2D
var shooting_state : State
var idle_state : State
var hitbox : Area2D
var detection : Area2D
var shoot : Area2D
var potential_shoot : Array
var leave_detection : Array

func initialize():
	hitbox = body.get_node("Hitbox")
	detection = body.get_node("Detection")
	shoot = body.get_node("ShootRange")
	shooting_state = get_parent().get_node("Shooting")
	idle_state = get_parent().get_node("Idle")

func process_state(delta: float):
	#print("Chasing")
	body.velocity = (target.position - body.position).normalized() * chase_speed
	body.move_and_slide()
	var hit_targets = hitbox.get_overlapping_bodies()
	
	var direction = (target.position - body.position).normalized()
	var angle = rad_to_deg(body.velocity.angle()) + 180
	
	leave_detection = detection.get_overlapping_bodies()
	potential_shoot = shoot.get_overlapping_bodies()
	
	if (leave_detection.is_empty()):
		change_state.emit(idle_state, "Idle")
	
	if (not potential_shoot.is_empty()):
		shooting_state.target = (potential_shoot[0] as CharacterBody2D)
		change_state.emit(shooting_state, "Shooting")
	
	#if (not hit_targets.is_empty()):
		#get_tree().get_root().get_node("Main/Player").hurt(1)
		#body.queue_free()
