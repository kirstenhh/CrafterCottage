extends Node2D

const SlotClass = preload("res://Slot.gd")
@onready var inventory_slots = $SlotsContainer
var holding_item = null

func _ready():
	for slot in inventory_slots.get_children():
		slot.connect("gui_input", Callable(self, "slot_gui_input").bind(slot))
	initialize_inventory()

#gui event on slot -> this
func slot_gui_input(event: InputEvent, slot: SlotClass):
	#left click
	if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT && event.pressed:
		if holding_item !=null:
			if !slot.item: # put down item in slot
				print('put down')
				slot.addToSlot(holding_item)
				print(holding_item.name)
				PlayerInventory.add_item(slot.get_index(), holding_item.item_name, holding_item.item_quantity)				
				holding_item = null
			else: #swap items
				if holding_item.item_name == slot.item.item_name: #stack items
					var stack_size = int(JsonDataLoader.pickup_item_data[slot.item.item_name]["MaxStackSize"])
					var can_add = stack_size - slot.item.item_quantity
					if can_add >= holding_item.item_quantity:
						slot.item.add_item_quantity(holding_item.item_quantity)
						PlayerInventory.add_item(slot.get_index(), holding_item.item_name, holding_item.item_quantity)			
						holding_item.queue_free()
						holding_item = null
					else:
						print('Error: oh no, ran out of space')
						slot.item.add_item_quantity(can_add)
						PlayerInventory.add_item(slot.get_index(), holding_item.item_name, can_add)			
						
						holding_item.decrease_item_quantity(can_add)
					
				else: #swap items
					var temp_item= slot.item
					PlayerInventory.remove_item(slot.get_index(), slot.item.item_name, slot.item.item_quantity)					
					slot.pickFromSlot()
					PlayerInventory.add_item(slot.get_index(), holding_item.item_name, holding_item.item_quantity)					
					slot.addToSlot(holding_item)
					holding_item = temp_item
					holding_item.global_position = get_global_mouse_position()
		elif slot.item: #item in slot: pick up
			holding_item = slot.item
			slot.pickFromSlot()
			PlayerInventory.remove_item(slot.get_index(),holding_item.item_name, holding_item.item_quantity)
			holding_item.global_position = get_global_mouse_position()
	if event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_RIGHT && event.pressed:
		pass	#TODO fill this in: right-click moves 1 item at a time

func _input(event):
	if holding_item:
		holding_item.global_position = get_global_mouse_position()

func initialize_inventory():
	var slots = $SlotsContainer.get_children()
	for i in range(slots.size()):
		if PlayerInventory.inventory.has(i):
			slots[i].initialize_item(PlayerInventory.inventory[i][0], PlayerInventory.inventory[i][1])
	

#Add an item that isn't being held (adds it to first empty slot)
func add_item_auto(item): 
	#find empty slot
	var emptyslot
	var i =0
	while !emptyslot && i<30:
		if inventory_slots[i.toString()].get_child_count == 0:
			emptyslot = inventory_slots[i.toString()]
		i+=1
	if emptyslot: 
		emptyslot.addToSlot(item)
	#else: throw_item (somewhere nearby)
	#slot.addToSlot(item)
