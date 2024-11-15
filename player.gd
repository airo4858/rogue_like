extends CharacterBody2D

@export var move_speed: float = 100.0

var can_jump : bool = true

func jump(event):
	get_tree().get_root().get_node("Main/Player/Hitbox").visible = false
	can_jump = false
	#Play Jump Animation
	#await animation to finish
	get_tree().get_root().get_node("Main/Player/Hitbox").visible = true
	can_jump = true

#func sweep(event):
	

#func stab(event):
	

func _physics_process(delta):
	if self.velocity == Vector2(0,1) * move_speed or self.velocity == Vector2(0,-1) * move_speed:
		move_speed * 2
	velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down") * move_speed * Vector2(2,1)
	move_and_slide()
	
	if (Input.is_action_pressed("jump")):
		jump("jump")
		print("JUMP!")
