extends Area2D

func _on_Area2D_body_entered(body):
	if body == GameManager.player:
		GameManager.player.inventory.add_item("Yellow Key", 1)
		queue_free()
