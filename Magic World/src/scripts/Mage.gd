extends KinematicBody2D

export var health = 200
export (PackedScene) var Bullet
var velocity : Vector2 = Vector2()
var FLOOR_NORMAL = Vector2.UP
var isleft : bool = false
const DIRECTION_RIGHT = 1
const DIRECTION_LEFT = -1
var direction = Vector2(DIRECTION_RIGHT, 1)

func _ready() -> void:
	add_to_group("Player")
	$AnimatedSprite.play("idle")

func set_direction(hor_direction):
	if hor_direction == 0:
		hor_direction = DIRECTION_LEFT # default to right if param is 0
	var hor_dir_mod = hor_direction / abs(hor_direction) # get unit direction
	apply_scale(Vector2(hor_dir_mod * direction.x, 1)) # flip
	direction = Vector2(hor_dir_mod, direction.y) # update direction
	
	
func shoot() -> void:
	$AnimatedSprite.play("shoot")
	var b = Bullet.instance()
	owner.add_child(b)
	b.transform = $Position2D.global_transform

func _physics_process(delta):
	if health <= 0:
		queue_free()
	velocity.y += 3000 * delta
	if Input.is_action_just_pressed("strike"):
		shoot()
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = -1300
	var is_interrupted : bool = Input.is_action_just_released("ui_up") and velocity.y < 0.0
	if is_interrupted:
		velocity.y = 0
	velocity.x = (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")) * 500
	if Input.is_action_just_pressed("ui_right"):
		isleft = false
	elif Input.is_action_just_pressed("ui_left"):
		isleft = true
	if isleft:
		set_direction(DIRECTION_LEFT)
	else:
		set_direction(DIRECTION_RIGHT)
		
	velocity = move_and_slide(velocity, FLOOR_NORMAL)


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "shoot":
		$AnimatedSprite.play("idle")
