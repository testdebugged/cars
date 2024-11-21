extends Node2D

@export var speed: int = 1
@export var mode: int = 0
@export var target: Node2D # target player
var car_base: RigidBody2D
var left_wheel: RigidBody2D
var right_wheel: RigidBody2D
var direction: bool =  true # SPEED * DIRETCION = force 

func _ready():
	car_base = $CarBase as RigidBody2D
	left_wheel = $LW as RigidBody2D
	right_wheel = $RW as RigidBody2D
	if target is Node2D:
		target = target.get_node("CarBase") as RigidBody2D
	if self.global_scale > Vector2(1,1):
		car_base.get_node("Base").scale = (global_scale * 1.5)
		left_wheel.get_node("Circle").scale = global_scale
		right_wheel.get_node("Circle").scale = global_scale
		car_base.mass = (scale.x + scale.y) / 1.5

func _process(delta):
	if mode == 2: # hunt target
		if target is RigidBody2D:
			direction = true if target.global_position.x - car_base.global_position.x > 0.1 else false

func _physics_process(delta):
	if mode != 0:
		_torque((int(direction) * 2) - 1, speed)

func _torque(dir: int, multiplier: int = 1):
	if round(car_base.linear_velocity.normalized().x) != dir * multiplier && round(car_base.linear_velocity.normalized().x) != 0:
		left_wheel.angular_velocity = (left_wheel.angular_velocity * 0.7)
		right_wheel.angular_velocity = (right_wheel.angular_velocity * 0.7)
	left_wheel.angular_velocity += (dir * multiplier) 
	right_wheel.angular_velocity += (dir * multiplier) 


func _on_right_body_entered(body):
	if mode == 1:
		direction = false


func _on_left_body_entered(body):
	if mode == 1:
		direction = true
