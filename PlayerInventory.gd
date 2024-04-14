extends Node

const COUNT_SLOTS = 30

var inventory = {
	0: ["PinkMushroom", 1] #slot_index: [item_name, item_quantity]
}

func add_item(position, name, quantity):
	if position == -1: #== no position given: put in first matching, or in first empty, slot
		for slot in inventory:
			if inventory[slot][0] == name:
				inventory[slot][1]+=quantity
				return
		#if not found in inventory
		for i in range(COUNT_SLOTS):
			if inventory.has(i) == false:
				inventory[i] = [name, quantity]
				return
		print("WARNING: Too many items. Dropped "+str(quantity)+" of item "+name)
	else: # positioned somewhere in the thing
		if !position in inventory|| inventory[position][0] == null: 
			print('new addition!')
			inventory[position] = [name, quantity]
		elif inventory[position][0]== name:
			print('stacking!')
			inventory[position][1]+=quantity
	print(inventory)
			
	#TODO: Change this to a user error message


func remove_item(position, name, quantity):
	print('removing item')
	print(str(position)+": "+str(inventory[position]))
	var remainder = inventory[position][1] - quantity
	if remainder > 0: #decrease quantity by quantity
		inventory[position][1] -= quantity
	elif remainder == 0:
		inventory.erase(position)
	else:
		print('Error: tried to remove more than available!')
		inventory.erase(position)
	print(inventory)
