extends State
class_name Enemy2_Shoot

@onready var target: CharacterBody2D
var projectile: Area2D
var is_chasing : bool = true
var shoot_time: float = 1.0
var projectile_speed: float = 100.0
@export var enemy_projectile: Resource
var chase_state : State
var leave_shooting : Array
var shootRange : Area2D

func initialize():
	target = get_node("Main/Player")
	shootRange = body.get_node("ShootRange")
	chase_state = get_parent().get_node("Chasing")

func process_state(delta: float):
	is_chasing = false
	aim_and_shoot(delta)
	var direction = (target.position - body.position).normalized()
	var angle = rad_to_deg(body.velocity.angle()) + 180
		
	leave_shooting = shootRange.get_overlapping_bodies()
	if (leave_shooting.is_empty()):
		change_state.emit(chase_state, "Chasing")
	
func aim_and_shoot(delta):
	look_at(target.position)
	shoot_time -= delta
	if (shoot_time < 0):
		shoot()
		shoot_time = 1.0
		projectile_speed += 1

func shoot():
	var new_projectile = enemy_projectile.instantiate()
	var direction = (target.position - body.position).normalized()
	get_parent().add_child(new_projectile)  # Add projectile to the scene
	var projectile_forward = body.position.direction_to(target.position)
	#var projectile_forward = Vector2.from_angle(rotation)
	new_projectile.fire(projectile_forward, projectile_speed)
	new_projectile.position = body.position  # Set the starting position
