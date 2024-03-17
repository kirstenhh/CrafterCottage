extends Node

const COUNT_SLOTS = 30

var inventory = {
	0: ["PinkMushroom", 1] #slot_index: [item_name, item_quantity]
}

func add_item(name, quantity):
	for slot in inventory:
		if inventory[slot][0] == name:
			inventory[slot][1]+=quantity
			print(inventory)
			return
	#if not found in inventory
	for i in range(COUNT_SLOTS):
		if inventory.has(i) == false:
			inventory[i] = [name, quantity]
			print(inventory)
			return
	print("WARNING: Too many items. Dropped "+str(quantity)+" of item "+name)
	#TODO: Change this to a user error message
