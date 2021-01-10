extends Node

var timer = 3
onready var boss = $MainCharacter

func _physics_process(delta):
	if boss == null:
		if timer > 0:
			timer -= delta
			return
		else:
			get_tree().change_scene("res://src/scenes/Level02.tscn")
