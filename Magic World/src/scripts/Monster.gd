extends KinematicBody2D

var health = 30
var velocity : Vector2 = Vector2()
const DIRECTION_RIGHT = 1
const DIRECTION_LEFT = -1
var direction = Vector2(DIRECTION_RIGHT, 1)
var isright : bool = true

func set_direction(hor_direction):
	if hor_direction == 0:
		hor_direction = DIRECTION_RIGHT # default to right if param is 0
	var hor_dir_mod = hor_direction / abs(hor_direction) # get unit direction
	apply_scale(Vector2(hor_dir_mod * direction.x, 1)) # flip
	direction = Vector2(hor_dir_mod, direction.y) # update direction
	

func _ready():
	add_to_group("enemy")
	velocity.x = 100

func _physics_process(delta):
	velocity.y += 3000 * delta
	if isright:
		set_direction(DIRECTION_RIGHT)
	elif !isright:
		set_direction(DIRECTION_LEFT)
	velocity = move_and_slide(velocity)

func _on_FloorDetector_body_exited(body):
	if isright:
		isright = false
	elif !isright:
		isright = true
	velocity.x *= -1
