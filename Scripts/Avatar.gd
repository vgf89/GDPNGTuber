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

func resetIdleImage():
	change_idle_image(config.defaultImage)
	
func resetTalkingImage():
	change_talking_image(config.defaultImage)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Sprite.scale.x = config.scale
	$Sprite.scale.y = config.scale
	
	delayTimer -= delta
	
	if delayTimer < 0:
		delayTimer = 0
	if values.inputVolume > config.threshold:
		delayTimer = config.delay
	
	var up = false
	if config.delay == 0: # Edge case: no delay
		up = (values.inputVolume > config.threshold)
	else:
		up = delayTimer > 0
	
	if up:
		$Sprite.texture = talkingTex
		$Sprite.position.y = lerp($Sprite.position.y, 0, config.animationSpeed * delta * 60)
		$Sprite.modulate = lerp($Sprite.modulate, Color.white, config.animationSpeed * delta * 60)
	else:
		$Sprite.texture = idleTex
		$Sprite.position.y = lerp($Sprite.position.y, config.verticalMovement, config.animationSpeed * delta * 60)
		var finalIdleDim = 1 - config.idleDim
		$Sprite.modulate = lerp($Sprite.modulate, Color(finalIdleDim, finalIdleDim, finalIdleDim, 1-config.idleTransparency), config.animationSpeed * delta * 60)
