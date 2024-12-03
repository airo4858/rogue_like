extends CharacterBody2D
class_name Enemy

@export var hp: int = 10

func hit(damage_number: int):
	hp -= damage_number
	if (hp <= 0):
		queue_free()

func _on_attack_hurtbox_body_entered(body: Node2D) -> void:
	print("HURT")
	body.hurt(1)
