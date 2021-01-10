extends Area2D

export var speed : float = 750

func _physics_process(delta) -> void:
	position += transform.x * speed * delta
	

func _on_Area2D_body_entered(body):
	if body.is_in_group("enemy"):
		body.health -= 10
	if body.is_in_group("Boss"):
		body.health -= 20
	queue_free()
