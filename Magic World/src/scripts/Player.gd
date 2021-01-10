extends KinematicBody2D

var health = 500
var target = null
const FLOOR_NORMAL: = Vector2.UP
var velocity: Vector2 = Vector2()
var isleft : bool = true
export var speed = 500
var isAttacking: bool = false
var isJumping: bool = false
var DIRECTION_RIGHT : float = 1
var DIRECTION_LEFT : float = -1
var direction: Vector2 = Vector2(DIRECTION_RIGHT, 1)

func _ready() -> void:
	add_to_group("Boss")

func set_direction(hor_direction):
	if hor_direction == 0:
		hor_direction = DIRECTION_LEFT # default to right if param is 0
	var hor_dir_mod = hor_direction / abs(hor_direction) # get unit direction
	apply_scale(Vector2(hor_dir_mod * direction.x, 1)) # flip
	direction = Vector2(hor_dir_mod, direction.y) # update direction

func strike():
	$RightAttack/CollisionShape2D.disabled = false
	$AnimatedSprite.play("strike")
	isAttacking = true

func _physics_process(delta):
	if health <= 0:
		queue_free()
	if isleft:
		set_direction(DIRECTION_LEFT)
	elif !isleft:
		set_direction(DIRECTION_RIGHT)
		
	if !is_on_floor():
		$AnimatedSprite.play("jump")
	velocity.y += 3000 * delta
	
	if target:
		if target.position.x > position.x  && !((target.position.x >= position.x - 80 and target.position.x < position.x) or (target.position.x <= position.x + 80 and target.position.x > position.x)) && !isAttacking:
			velocity.x = 300
			isleft = false
		elif target.position.x < position.x && !((target.position.x >= position.x - 80 and target.position.x < position.x) or (target.position.x <= position.x + 80 and target.position.x > position.x)) && !isAttacking:
			velocity.x = -300
			isleft = true
		else:
			velocity.x = 0
			if $Timer.is_stopped():
				$Timer.start()
				strike()
	
	if velocity.x != 0 and isAttacking == false and is_on_floor():
		$AnimatedSprite.play("run")
	elif isAttacking == false and is_on_floor():
		$AnimatedSprite.play("idle")
	velocity = move_and_slide(velocity, Vector2(0, -1))



func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "strike":
		isAttacking = false
		$RightAttack/CollisionShape2D.disabled = true


func _on_PlayerDetector_body_entered(body):
	if body.is_in_group("Player"):
		target = body


func _on_PlayerDetector_body_exited(body):
	target = null


func _on_RightAttack_body_entered(body):
	if body.is_in_group("Player"):
		body.health -= 20
