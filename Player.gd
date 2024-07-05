extends CharacterBody2D

@export var speed = 50
const JUMP_VELOCITY = -400.0
@export var initial_velocity := Vector2(0, 0)
var collision_count := 0

@onready var player = $"."
@onready var world = $".."
@onready var tile_map: TileMap = $"../TileMap"
@onready var label: Label = $"../HUD/Label"

signal hit


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func get_input():
	var input_direction = Input.get_vector("Left", "Right", "Up", "Down")
	#print('we have input') #spam
	#print(input_direction)
	#print('x is '+str(input_direction.x))
	
	if($Sprite2D/AnimatedSprite2D):
		if input_direction.y > 0:
			#print('we are walking down')
			$Sprite2D/AnimatedSprite2D.play("walk_down")
		elif input_direction.y < 0:
			#print('we are walking up')
			$Sprite2D/AnimatedSprite2D.play("walk_up")
		elif input_direction.x > 0:
			#print('we are walking right')
			$Sprite2D/AnimatedSprite2D.scale.x = -1
			#$Sprite2D/AnimatedSprite2D.flip_h == true
			$Sprite2D/AnimatedSprite2D.play("walk_right")
		elif input_direction.x < 0:
			#print('we are walking left')
			$Sprite2D/AnimatedSprite2D.scale.x = 1
			$Sprite2D/AnimatedSprite2D.play("walk_left")
		elif Input.is_action_just_released("Save"):
			print("saving")
			$"/root/World".save_game()
			print("saved")
		elif Input.is_action_just_released("Load"):
			print("loading from Input.is_action_just_released(Load)")
			$"/root/World".load_game()
			print("load attempt complete from Input.is_action_just_released(Load)")
			
		else:
			if($Sprite2D/AnimatedSprite2D):
				$Sprite2D/AnimatedSprite2D.stop()
		
	velocity = input_direction * speed

func _physics_process(delta):
	get_input()
	move_and_slide()
	
	# we are setting the plauer position her are storing it in the Global script
	#print("player.position: " + str(player.position))
	$"/root/Global".myGlobalPlayerX = player.position.x
	$"/root/Global".myGlobalPlayerY = player.position.y
	

	#print("player.position" + str(player.position))
	
	#var tileBelow was here
	if (tile_map):
		var tileBelow = tile_map.local_to_map(player.position)
		var tileBelowData : TileData = tile_map.get_cell_tile_data(0, tileBelow)
		if tileBelowData:
			#print("spammy:"+str(tileBelow))
			#print('here is tiledata '+str(tileBelowData))
			if tileBelowData.get_custom_data("can_place_seeds") and \
			 $"/root/Global".alreadyOnTheCropTile == false:
				print("we can plant here")
				$"/root/Global".planthere()
				$"/root/Global".timecounter -= 5
				label.text = "updated"
				$"/root/Global".alreadyOnTheCropTile = true
			elif not tileBelowData.get_custom_data("can_place_seeds"):
				$"/root/Global".alreadyOnTheCropTile = false
			

	#print("tileBelow.z_index is now"+str(tileBelow.z_index))
	#print(tileBelow.z_index)
	#print(str(tileBelow) + " - " + str($"/root/Global".onTheTile)) 
	
	#if (tileBelow.x == 9) and (tileBelow.y == 5) and ($"/root/Global".onTheTile == false):
	#	$"/root/Global".onTheTile = true		
	#	print("we are on the tile")
	#	$"/root/Global".timecounter -= 10
	#elif (tileBelow.x != 9) and (tileBelow.y != 5) :
	#	$"/root/Global".onTheTile = false
		
		

	
	var collision = move_and_collide(velocity * delta)
	#print(velocity * delta)
	if collision:
		print("I collided with ", collision.get_collider().name)
		

func playerhello():
	print("hello from playerhello()")
	
func _ready():
	print("hello from player _ready()")
	pass # Replace with function body.

