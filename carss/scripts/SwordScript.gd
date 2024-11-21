extends Node2D

@export var car_base: RigidBody2D
var target: float
var handle: CharacterBody2D
var knockback: float = 0.05

func _ready():
	handle = $Handle as CharacterBody2D


func _physics_process(delta):
	if car_base:
		target = (car_base.linear_velocity.normalized().x * 100)
		handle.global_position = car_base.global_position
	if target:
		handle.global_rotation_degrees = lerp(handle.global_rotation_degrees,target,knockback)
	if knockback < 0.05:
		knockback += 0.01
	else:
		knockback = 0.05


func _on_sword_body_entered(body):
	if body is RigidBody2D:
		knockback += -0.02
		car_base.linear_velocity -= (body.global_position.normalized() * 150)
		
