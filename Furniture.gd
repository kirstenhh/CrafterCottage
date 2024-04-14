extends StaticBody2D

var item_name = ""
var crafting_item = false
var animated = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Picture.texture = load("res://art/pickup_items/"+item_name+".tres")
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func fit_collision(width=null, height=null):
	#set collision shape to picture
	if width == null:
		width = $Picture.texture.get_width()
	if height == null:
		height = $Picture.texture.get_height()
	var coltransform = get_node ("CollisionShape2D"). get_shape()
	coltransform.set_size(Vector2(width/2, height))


func interact():
	print("My name is "+item_name)
	
	#Depending on item type
