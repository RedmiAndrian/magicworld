extends Node

signal player_initialised

var player
var active_items
var curr_index = 0
var new_index = 0
var whole_items = Array()
var temp = Array()
func _process(delta):
	if not player:
		initialise_player()
		print(player.inventory)
		print(player.inventory.get_items())
		for i in player.inventory.get_items():
			temp.append(i.item_reference)
		print(temp)
		active_items = temp[curr_index]
		return
	for i in player.inventory.get_items():
			temp.append(i.item_reference)
	if Input.is_action_just_pressed("next_item_e"):
		new_index = (curr_index + 1) % ItemDatabase.items.size()
		curr_index = new_index
		print(temp[curr_index])
	if Input.is_action_just_pressed("contoh"):
		player.inventory.removeItem(curr_index)
		temp.remove(curr_index)
	
func initialise_player():
	player = get_tree().get_root().get_node("/root/Level/Mage")
	if not player:
		return
	emit_signal("player_initialised", player)
	player.inventory.connect("inventory_changed", self, "_on_player_inventory_changed")
	var existing_inventory = load("user://inventory.tres")
	if existing_inventory && player.inventory.get_items().size() >= 1:
		player.inventory.set_items(existing_inventory.get_items()) 
	else:
		player.inventory.add_item("Fireball", 1)
		
	
func _on_player_inventory_changed(inventory):
	ResourceSaver.save("user://inventory.tres", inventory)

