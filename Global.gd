extends Node
@onready var hud: CanvasLayer = $HUD
@onready var player = $Player

var globalTestNum = 3
var timecounter = 0
var alreadyOnTheCropTile = false
var myGlobalPlayerX = 0
var myGlobalPlayerY = 0

func sayhello():
	print("Hello from Global.gd func sayhello()")

func planthere():
	#print("I am planting here in Global")
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	#print("Hello from Global.gd func _ready()")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print("hello from func _process(delta):")
	#print ("player at " + str(myGlobalPlayerX) \
	#			+ " and "+str(myGlobalPlayerY) + " in global vars")
	pass 
	
#func updateLabel():
#	#$HUD/Label.text = "The count is now "+str($"/root/Global".timecounter)


