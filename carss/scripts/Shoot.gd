extends Node2D

@export var projectile: PackedScene
@export var attachment: Node2D
var barrel: Node2D
var pivot: CharacterBody2D
var cooldown: Timer


func _ready():
	pivot = $pivot as CharacterBody2D
	barrel = $pivot/b/emit as Node2D
	cooldown = $CD as Timer

func _physics_process(delta):
	if Input.is_action_pressed("shoot") && cooldown.time_left == 0:
		if projectile:
			var init = projectile.instantiate()
			self.add_child(init)
			init.global_rotation = barrel.global_rotation
			init.global_position = barrel.global_position
			init.apply_central_impulse(Vector2(cos(init.rotation), sin(init.rotation)) * 2000)
			cooldown.start()

	if attachment:
		pivot.global_position = attachment.global_position
	pivot.look_at(get_global_mouse_position())
