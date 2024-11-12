extends CharacterBody2D

@export var move_speed: float = 150.0

func _physics_process(delta):
	velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down") * move_speed
	move_and_slide()
