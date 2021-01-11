extends KinematicBody2D

var vava


func _ready():
	var b = ItemDatabase.get_item("Yellow Key")
	vava = {
		item_reference = b,
		quantity = 1,
	}
	print(vava)
func _on_Area2D_body_entered(body):
	if body.name == "Mage":
		var a = GameManager.player.inventory.get_items()
		print_debug(vava)
		print(GameManager.player.inventory.get_items())
		for i in GameManager.player.inventory.get_items():
			print(i)
			if i.item_reference == vava.item_reference:
				GameManager.player.inventory.keyUsed(vava.item_reference)
				queue_free()
