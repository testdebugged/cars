extends Area2D
@export var point: Node2D
var particle: CPUParticles2D

func _ready():
	particle = $hit as CPUParticles2D

func _on_body_entered(body):
	if point:
		if body is RigidBody2D:
			body.linear_velocity += (point.global_position.normalized() * 750)
			particle.global_position = body.global_position 
			particle.emitting = true
			
