extends RigidBody2D
var victims: Array
@export var particles_emitted: Array
var frame_check: bool = false

func _on_body_entered(body):
	if frame_check:
		$CollisionShape2D.queue_free()
		detonate(victims)
		if particles_emitted:
			for i in particles_emitted:
				get_node(i).emitting = true

func _on_radius_body_entered(body):
	frame_check = true
	if body is RigidBody2D:
		victims.append(body)


func _on_radius_body_exited(body):
	if victims.has(body):
		victims.erase(body)

func detonate(affected: Array):
	if affected:
		for target in affected:
			target.linear_velocity = -((self.global_position - target.global_position).normalized() + Vector2(0,-0.5)) * 1250



func _on__finished():
	queue_free()
