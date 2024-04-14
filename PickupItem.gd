extends CharacterBody2D

var item_name
var item_quantity
var player = null

# Called when the node enters the scene tree for the first time.
func _ready():
	#TODO probability curves based on location?
	var rand = randi()%4
	if rand == 0:
		item_name = "PinkMushroom"
	elif rand == 1:
		item_name = "Berries"
		
	elif rand ==2:
		item_name = "RedFlower"
	else:
		item_name = "MagicTree"
	
	$Picture.texture = load("res://art/pickup_items/"+item_name+".tres")
	
	var width = $Picture.texture.get_width()
	var height = $Picture.texture.get_height()
	fit_collision(width, height)
	var spawn = int(JsonDataLoader.pickup_item_data[item_name]["SpawnSize"])
	item_quantity = randi()%spawn+ 1
	$Label.text = str(item_quantity)
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	pass
		

func pick_up_item(body):
	player = body
	print("picking up "+item_name)
	PlayerInventory.add_item(-1, item_name, item_quantity)
	queue_free()

#resize item to fit in a box. Mostly used by inventory.
func resize_sprite(width,height):
	var oldwidth = $Picture.texture.get_width()
	var oldheight = $Picture.texture.get_height()
	var xscale = float(width)/oldwidth
	var yscale = float(height)/oldheight
	var smallest = xscale if xscale < yscale else yscale
	var scale = Vector2(smallest,smallest)
	$Picture.scale = scale
	fit_collision(width, height)

#resize the collision shape to fit around the object. Currently still kind of buggy. 
func fit_collision(width=null, height=null):
	#set collision shape to picture
	if width == null:
		width = $Picture.texture.get_width()
	if height == null:
		height = $Picture.texture.get_height()
	var coltransform = get_node ("CollisionShape2D"). get_shape()
	coltransform.set_size(Vector2(width/2, height))

func add_item_quantity(q = 1):
	item_quantity+=q
	$Label.text = str(item_quantity)
	
func decrease_item_quantity(q=1):
	item_quantity-=q
	$Label.text = str(item_quantity)

func set_item(name, quantity):
	item_name = name
	item_quantity = quantity
	$Picture.texture = load("res://art/pickup_items/"+item_name+".tres")
	$Label.text = str(item_quantity)
	
