extends HSlider

var config

# Called when the node enters the scene tree for the first time.
func _ready():
	config = $"/root/Node2D/Configuration"
	value = config.threshold
	$"../Label".text = str(value)

func _on_thresholdSlider_value_changed(value):
	config.threshold = value
	config.save()
	$"../Label".text = str(value)
