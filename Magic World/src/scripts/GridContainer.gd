extends GridContainer

var active_item
var character_items = Array()
func _ready():
	GameManager.connect("player_initialised", self, "_on_player_initialised")
	print(character_items)
	
func _on_player_initialised(player):
	player.inventory.connect("inventory_changed", self, "_on_player_inventory_changed")

func _on_player_inventory_changed(inventory):
	for n in get_children():
		n.queue_free()
	
	for item in inventory.get_items():
		var item_label = Label.new()
		item_label.text = "%s" % item.item_reference.name
		add_child(item_label)
	

func _process(delta):
	if Input.is_action_just_pressed("next_item_e"):
		active_item = GameManager.player.inventory
