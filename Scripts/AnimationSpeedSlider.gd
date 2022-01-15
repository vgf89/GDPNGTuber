extends HSlider

var config

# Called when the node enters the scene tree for the first time.
func _ready():
	config = $"/root/Node2D/Configuration"
	value = config.animationSpeed
	$"../Label".text = str(value)

func _on_HSlider_value_changed(value):
	config.animationSpeed = value
	config.save()
	$"../Label".text = str(value)
