extends Node2D

@export var wheel_left: RigidBody2D
@export var wheel_right: RigidBody2D
@export var car_base: RigidBody2D
@export var dash_cd: Timer
@export var speed: int = 1

signal _dash

func _physics_process(delta):
	var direction = Input.get_axis("LEFT", "RIGHT")
	if direction:
		_torque(direction, speed)
	else:
		wheel_left.angular_velocity = wheel_left.angular_velocity * 0.7
		wheel_right.angular_velocity = wheel_right.angular_velocity * 0.7
	
	car_base.angular_velocity -= (car_base.rotation_degrees / 700) 
	if Input.is_action_just_pressed("UP"):
		car_base.linear_velocity.y -= 500
		if car_base.rotation_degrees != 0:
			car_base.rotation_degrees -= car_base.rotation_degrees / 10
		if direction && dash_cd.time_left == 0:
			_force(direction, speed)
			_dash.emit()
			dash_cd.start()

func _force(dir: int, multiplier: int = 1):
	car_base.linear_velocity.x = (dir * 1250)

func _torque(dir: int, multiplier: int = 1):
	wheel_left.angular_velocity += (dir * multiplier)
	wheel_right.angular_velocity += (dir * multiplier)


func _on_detect_body_entered(body):
	car_base.linear_velocity.y -= 100
