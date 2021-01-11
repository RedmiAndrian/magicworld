extends Resource
class_name ItemResource

export var name : String
export var stackable : bool = false
export var max_stack_size : int = 1

# Examples of more properties we could store
enum ItemType {
	GENERIC, CONSUMABLES, QUEST, EQUIPMENT
}
export(ItemType) var type
export var texture : Texture
export var mesh : Mesh
