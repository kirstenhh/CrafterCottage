extends Panel
var ItemClass = preload("res://PickupItem.tscn")
var item = null

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
#	if randi() % 4 == 0:
#		item = ItemClass.instance()
#		addToSlot(item)
#		item.resize_sprite(25,25)

func pickFromSlot():
	remove_child(item)
	var inventoryNode = find_parent("Inventory")
	inventoryNode.add_child(item) # the item that we're now "holding"
	item = null

#assign new item to slot. Note: doesn't check if the slot already has an item.
func addToSlot(new_item):
	item = new_item
	item.position = Vector2(12,12) #width/2, height/2 (center of slot)
	var inventoryNode = find_parent("Inventory")
	#var check = inventoryNode.get_node_or_null(item.item_name) 
	if inventoryNode.holding_item:
		inventoryNode.remove_child(item) # the item that we're now "holding"
#		inventoryNode.holding_item.queue_free()
#		inventoryNode.holding_item = null
	#TODO: figure out how to defer the above 
	add_child(item)
	

func initialize_item(name, quantity):
	if item == null:
		item = ItemClass.instantiate()
		addToSlot(item)
	item.set_item(name, quantity)
	print('set to '+str(quantity)+" "+name+'s')
	item.resize_sprite(25,25)
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
