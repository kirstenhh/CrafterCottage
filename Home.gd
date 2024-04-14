extends Node2D

var editMode
var furniture = preload("res://Furniture.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	editMode = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	#left click
	if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
		var holding = $"../UI/Inventory".holding_item
		if editMode:
			if holding:
				#TODO: check if object at position -> don't do anything
				print(holding)
				var placedItem = furniture.instantiate()
				placedItem.item_name = holding.item_name
				placedItem.position = get_global_mouse_position()
				$FurnitureContainer.add_child(placedItem)
				
				if(holding.item_quantity <=1):
					print('last one!')
					$"../UI/Inventory".holding_item.queue_free()
					
					$"../UI/Inventory".holding_item = null
				else:
					holding.decrease_item_quantity(1)
			else:
				print(event.position)
				print(get_children())
				#check if there's an object at click location
		else:
			pass
			#check object clicked on: if interaction = crafting, check if holding craftable
			# else if animated, trigger animation
				
