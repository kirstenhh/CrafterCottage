extends Node2D

signal start_game

 
@export var pickupitem: PackedScene

@onready var camera =$Camera2D
@onready var player = $Player
var screen_size
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	showHome()
	var pickupSpawn = pickupitem.instantiate()
	pickupSpawn.set_position(player.get_position() + Vector2(12,12))
	$Forage.add_child(pickupSpawn)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	camera.set_position(player.get_position()) 

func _input(event):
	if event.is_action_pressed("pickup"):
		$UI/Inventory.initialize_inventory()
	if event.is_action_pressed("toggle_scene"):
		if $Home.visible: 
			_on_StartButton_pressed()
		else: 
			_on_HomeButton_pressed()
	#elif event.is_action_pressed("go out"):

func _on_StartButton_pressed():
	showForage()

func _on_SavePlacementButton_pressed():
	$Home.editMode = !$Home.editMode
	
	
func _on_HomeButton_pressed():
	#emit_signal("end_forage")
	showHome()
	
#show home, hide Forage
func showHome():
	$Home.process_mode = Node.PROCESS_MODE_ALWAYS
	$Forage.process_mode = Node.PROCESS_MODE_DISABLED
	
	$Home.show()
	$UI/HomeUI.show()
	$Forage.hide()	
	$UI/ForageUI.hide()
	
#show forage, hide home
func showForage():
	$Forage.process_mode = Node.PROCESS_MODE_ALWAYS
	$Home.process_mode = Node.PROCESS_MODE_DISABLED
	$Forage.show()
	$UI/ForageUI.show()
	$Home.hide()
	$UI/HomeUI.hide()
