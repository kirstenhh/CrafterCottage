extends Node2D

signal start_game

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
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	camera.set_position(player.get_position()) 

func _input(event):
	if event.is_action_pressed("pickup"):
		print("pickup from main!")
		$UI/Inventory.initialize_inventory()

func _on_StartButton_pressed():
	emit_signal("start_game")
	print('pressed start')
	showForage()

func _on_SavePlacementButton_pressed():
	print("Toggle mode")
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
