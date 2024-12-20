extends CharacterBody2D
class_name Enemy

signal healthChanged
signal enemyDeath

@export var max_hp: int = 10
@export var hp: int = 10

func hit(damage_number: int):
	hp -= damage_number
	healthChanged.emit()
	if (hp <= 0):
		queue_free()
		enemyDeath.emit()

func _on_attack_hurtbox_body_entered(body: Node2D) -> void:
	body.hurt(1)
