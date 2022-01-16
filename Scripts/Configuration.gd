extends Node

var config = ConfigFile.new()
var defaultImage = "res://Images/icon.png"
var idleImage = defaultImage
var talkingImage = defaultImage

var verticalMovement = 20
var idleDim = 0.2
var idleTransparency = 0
var animationSpeed = 0.5
var filter = false
var scale = 1
var threshold = -80
var delay = 0.3
var audioDevice = "Default"

var path = "user://PNGTuber.cfg"

# Called when the node enters the scene tree for the first time.
func _ready():
	var err = config.load(path)
	if err != OK:
		return
	
	idleImage = config.get_value("avatar", "idleImage", idleImage)
	talkingImage = config.get_value("avatar", "talkingImage", talkingImage)
	filter = config.get_value("avatar", "filter", filter)
	verticalMovement = config.get_value("avatar", "verticalMovement", verticalMovement)
	idleDim = config.get_value("avatar", "idleDim", idleDim)
	idleTransparency = config.get_value("avatar", "idleTransparency", idleTransparency)
	animationSpeed = config.get_value("avatar", "animationSpeed", animationSpeed)
	scale = config.get_value("avatar", "scale", scale)
	threshold = config.get_value("avatar", "threshold", threshold)
	delay = config.get_value("avatar", "delay", delay)
	audioDevice = config.get_value("avatar", "audioDevice", audioDevice)

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
