extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

var items_in_range = {}

func _on_PickupZone_body_entered(body):
	#remove self from list
	if items_in_range.has('Player'):
		items_in_range.erase('Player')
	#fill in items_in_range 
	#TODO add check: PickupItems only!!
	items_in_range[body.name] = body

func _on_PickupZone_body_exited(body):
	#remove from list
	if items_in_range.has(body.name):
		items_in_range.erase(body.name)
	#TODO add check: PickupItems only!!
