extends Node

var pickup_item_data: Dictionary
# might have to change names: craft_supplies, sellable, furniture?
# furniture_data #buyable, placeable
# crafting trees, storefronts


# Called when the node enters the scene tree for the first time.
func _ready():
	pickup_item_data = LoadData("res://data/pickup_item_data.json")


func LoadData(file_path):
	var json_data
	var file_data = FileAccess.open(file_path, FileAccess.READ)
	var test_json_conv = JSON.new()
	test_json_conv.parse(file_data.get_as_text())
	json_data = test_json_conv.get_data()
	file_data.close()
	print(json_data)
	return json_data
