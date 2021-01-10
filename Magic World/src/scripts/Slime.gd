extends KinematicBody2D

export var health = 50
var target = null
var velocity: Vector2 = Vector2()
var damageTaken : bool = false

func _ready():
	$AnimatedSprite.play("idle")
	add_to_group("enemy")
	

func _physics_process(delta):
	if health <= 0:
			queue_free()
	if target and !damageTaken:
		if target.position.x > position.x:
			velocity.x = 50
		elif target.position.x < position.x:
			velocity.x = -50
		velocity.y = 300
	else:
		velocity = Vector2(0, 300)
	velocity = move_and_slide(velocity * 200 * delta)

func _on_AttackDetector_area_entered(area):
	if $InvulnerabilityTimer.is_stopped():
		damageTaken = true
		$InvulnerabilityTimer.start()
		


func _on_PlayerChecker_body_entered(body):
	if body.is_in_group("Player"):
		target = body


func _on_PlayerChecker_body_exited(body):
	target = null


func _on_AttackDetector_area_exited(area):
	velocity.y = 300
	damageTaken = false
