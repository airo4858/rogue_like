extends State
class_name Enemy1_Chasing

@export var chase_speed: float = 55.0
var target: CharacterBody2D
var hitbox : Area2D

func initialize():
	hitbox = get_node("HitboxShape")

func process_state(delta: float):
	body.velocity = (target.position - body.position).normalized() * chase_speed
	body.move_and_slide()
	var hit_targets = hitbox.get_overlapping_bodies()
	
	var direction = (target.position - body.position).normalized()
	var angle = rad_to_deg(body.velocity.angle()) + 180
		
	#if (not hit_targets.is_empty()):
		#get_tree().get_root().get_node("Main/Player").hurt(1)
		#body.queue_free()
