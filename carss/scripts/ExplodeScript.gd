extends Area2D

var victims: Array

func _on_body_entered(body):
	if body is RigidBody2D:
		victims.append(body)

func _explode():
	if victims:
		for i in victims:
			i.linear_velocity = -((self.global_position - i.global_position).normalized() + Vector2(0,-1)) * 2500


func _on_body_exited(body):
	if victims.has(body):
		victims.erase(body)
