# TODO: Combine all of these duplicated slider classes into a single prefab

extends HSlider

var config

# Called when the node enters the scene tree for the first time.
func _ready():
	config = $"/root/Node2D/Configuration"
	value = config.scale
	$"../Label".text = str(value)

func _on_scaleSlider_value_changed(value):
	config.scale = value
	config.save()
	$"../Label".text = str(value)
