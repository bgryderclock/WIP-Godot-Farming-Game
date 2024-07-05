extends Node

const Global = preload("res://Global.gd")
const myplayer = preload("res://Player.gd")
@onready var sprite_2d: Sprite2D = $Player/Sprite2D
@onready var player : CharacterBody2D = $Player

func load_game():
	print("starting load_game")
	if not (player):
		print("there is no player in world load_game")
	else:
		print("in world load_game player.global_position is >  "+str(player.global_position))
	
	if not FileAccess.file_exists("user://samegame.save"):
		print("failed to load user://samegame.save")
		return
		
	var save_game = FileAccess.open("user://samegame.save", FileAccess.READ)
	
	while save_game.get_position() < save_game.get_length():
		var json_string = save_game.get_line()
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		var node_data = json.get_data()
		print("node_data")
		print(node_data)
		#print(type_string(typeof(node_data))) #dictionary
		#print(type_string(typeof(node_data["position"]))) #string
		#print(type_string(typeof(node_data["positionx"]))) #float
		
		if($Player):
			print("loading player x")
			$Player.global_position.x = node_data["positionx"]
			print("loading player y")
			$Player.global_position.y = node_data["positiony"]
		else:
			print("no player to update in world.gd load_game()")
	
		
		#print( "this loading x is "+ str( Vector2(node_data["position"]) ) )
		#print("/home/user/.local/share/GodotFarmingGameSave/")
		
			
		
func _on_timer_timeout():
	$"/root/Global".timecounter += 1 
	print($"/root/Global".timecounter)
	$HUD/Label.text = "The count is "+str($"/root/Global".timecounter)
	
	

func save():
	var save_dict = {
		
		"score" : 0,
		"positionx" : $"/root/Global".myGlobalPlayerX,
		"positiony" : $"/root/Global".myGlobalPlayerY
	}
	
	return save_dict

func save_game():
	var save_game = FileAccess.open("user://samegame.save", FileAccess.WRITE)
	var json_string = JSON.stringify(save())
	save_game.store_line(json_string)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	print("starting world")
	#$"/root/Global".sayhello()
	if not (player):
		print("there is no player in world ready")
	else:
		print("in world, player.global_position in _ready func "+str(player.global_position))
		#player.position.x = 0 #this works, player moves
