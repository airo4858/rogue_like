extends CharacterBody2D
class_name Enemy3

signal healthChanged
signal enemyDeath

@export var max_hp: int = 4
@export var hp: int = 4

func hit(damage_number: int):
	hp -= damage_number
	healthChanged.emit()
	if (hp <= 0):
		queue_free()
		enemyDeath.emit()

func _on_attack_hurtbox_body_entered(body: Node2D) -> void:
	body.hurt(2)
