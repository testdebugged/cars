extends Node2D

var camera: Camera2D
var particle: CPUParticles2D
var orbit: CPUParticles2D
@export var PlayerCarBase: RigidBody2D
var offset: Vector2 = Vector2(0,-55)
var c_v: float = 1


func _ready():
	camera = $Camera2D as Camera2D
	particle = $Camera2D/p as CPUParticles2D
	orbit = $Camera2D/o as CPUParticles2D

func _process(_delta):
	particle.global_position = PlayerCarBase.global_position
	self.position = (PlayerCarBase.position + offset)
	camera.zoom = Vector2(c_v,c_v)
	camera.position_smoothing_speed = (5) + (100 * abs(c_v - 1))
	if abs(PlayerCarBase.linear_velocity.x + PlayerCarBase.linear_velocity.y) >= 700:
		if c_v <= 0:
			c_v = 0.0001
		elif c_v != 0.0001:
			c_v -= 0.0001
		particle.emitting = true
	elif c_v >= 1:
		c_v = 1
		particle.emitting = false
	else:
		particle.emitting = false
		c_v = c_v * 1.05



func _on_player__dash():
	orbit.emitting = true
	$Explode._explode()
