extends Node

var config = ConfigFile.new()
var idleImage = "icon.png"
var talkingImage = "icon.png"
var verticalMovement = 20
var idleDim = 0.2
var idleTransparency = 0
var animationSpeed = 0.5
var filter = false
var scale = 1
var threshold = 20
var delay = 0.3
var audioDevice = "Default"

var path = "user://PNGTuber.cfg"

# Called when the node enters the scene tree for the first time.
func _ready():
	var err = config.load(path)
	if err != OK:
		return
	
	idleImage = config.get_value("avatar", "idleImage", "icon.png")
	talkingImage = config.get_value("avatar", "talkingImage", "icon.png")
	filter = config.get_value("avatar", "filter", false)
	verticalMovement = config.get_value("avatar", "verticalMovement", 20)
	idleDim = config.get_value("avatar", "idleDim", 0.2)
	idleTransparency = config.get_value("avatar", "idleTransparency", 0)
	animationSpeed = config.get_value("avatar", "animationSpeed", 0.2)
	scale = config.get_value("avatar", "scale", 1)
	threshold = config.get_value("avatar", "threshold", 20)
	delay = config.get_value("avatar", "delay", 0.3)
	audioDevice = config.get_value("avatar", "audioDevice", "Default")

func save():
	config.set_value("avatar", "idleImage", idleImage)
	config.set_value("avatar", "talkingImage", talkingImage)
	config.set_value("avatar", "filter", filter)
	config.set_value("avatar", "verticalMovement", verticalMovement)
	config.set_value("avatar", "idleDim", idleDim)
	config.set_value("avatar", "idleTransparency", idleTransparency)
	config.set_value("avatar", "animationSpeed", animationSpeed)
	config.set_value("avatar", "scale", scale)
	config.set_value("avatar", "threshold", threshold)
	config.set_value("avatar", "delay", delay)
	config.set_value("avatar", "audioDevice", audioDevice)
	config.save(path)
