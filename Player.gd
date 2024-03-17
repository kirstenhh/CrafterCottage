extends CharacterBody2D

const WALK_SPEED = 5

var player_velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.

func _physics_process(delta):
#	var player_velocity = Vector2.ZERO # The player's movement vector.
	var dir

	if Input.is_action_pressed("move_up"):
		player_velocity.y = -WALK_SPEED
		dir = 1
	elif Input.is_action_pressed("move_down"):
		player_velocity.y = WALK_SPEED
		dir = 3
	else:
		player_velocity.y = 0
		
	if Input.is_action_pressed("move_left"):
		player_velocity.x = -WALK_SPEED
		dir = 2
	elif Input.is_action_pressed("move_right"):
		player_velocity.x = WALK_SPEED
		dir = 4
	else:
		player_velocity.x = 0

		
	if player_velocity.length() > 0:
		player_velocity = player_velocity.normalized() * WALK_SPEED
		move_and_collide(player_velocity)
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	
	if dir == 1:
		$AnimatedSprite2D.animation = "up"
	elif dir == 2:
		$AnimatedSprite2D.animation = "left"
	elif dir == 3:
		$AnimatedSprite2D.animation = "down"
	elif dir == 4:
		$AnimatedSprite2D.animation = "right"

func _input(event):
	if event.is_action_pressed("pickup"):
		for item in $PickupZone.items_in_range:
			$PickupZone.items_in_range[item].pick_up_item(self)
		for item in $PickupZone.items_in_range:
			$PickupZone.items_in_range.erase(item)
			
