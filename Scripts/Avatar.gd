extends Control

var idleTex = ImageTexture.new()
var idleImg = Image.new()
var talkingTex = ImageTexture.new()
var talkingImg = Image.new()

var config
var values

var delayTimer = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	config = $"../../Configuration"
	values = $"../../Values"
	change_idle_image(config.idleImage)
	change_talking_image(config.talkingImage)
	$Sprite.scale.x = config.scale
	$Sprite.scale.y = config.scale
	pass


func select_idle_image_slot():
	$"../IdleImageDialog".popup()
	
func select_talking_image_slot():
	$"../TalkingImageDialog".popup()
	
func change_idle_image(path:String):
	var err = idleImg.load(path)
	if err != OK:
		return
	var flag = false
	if (config.filter):
		flag = Texture.FLAG_FILTER
	idleTex.create_from_image(idleImg, flag)
	config.idleImage = path
	config.save()
	
		
func change_talking_image(path:String):
	var err = talkingImg.load(path)
	if err != OK:
		return
	var flag = false
	if (config.filter):
		flag = Texture.FLAG_FILTER
	talkingTex.create_from_image(talkingImg, flag)
	config.talkingImage = path
	config.save()
	
func set_filter(mode:bool):
	config.filter = mode
	change_talking_image(config.talkingImage)
	change_idle_image(config.idleImage)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Sprite.scale.x = config.scale
	$Sprite.scale.y = config.scale
	if (values.inputVolume) > config.threshold: # minimum volume
		$Sprite.texture = talkingTex
		$Sprite.position.y = lerp($Sprite.position.y, 0, config.animationSpeed)
		$Sprite.modulate = lerp($Sprite.modulate, Color.white, config.animationSpeed)
		delayTimer = config.delay
		
	else:
		delayTimer -= delta
		if (delayTimer <= 0):
			$Sprite.texture = idleTex
			$Sprite.position.y = lerp($Sprite.position.y, config.verticalMovement, config.animationSpeed)
			var finalIdleDim = 1 - config.idleDim
			$Sprite.modulate = lerp($Sprite.modulate, Color(finalIdleDim, finalIdleDim, finalIdleDim, 1-config.idleTransparency), config.animationSpeed)
