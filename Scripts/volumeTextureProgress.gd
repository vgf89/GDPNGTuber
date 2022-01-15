extends TextureProgress

var values
var config

# Called when the node enters the scene tree for the first time.
func _ready():
	values = $"/root/Node2D/Values"
	config = $"/root/Node2D/Configuration"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	value = values.inputVolume
	if (value > config.threshold):
		self.tint_progress = Color.green
	else:
		self.tint_progress = Color.red
	
