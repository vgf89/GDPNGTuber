extends OptionButton

var config

# Called when the node enters the scene tree for the first time.
func _ready():
	config = $"/root/Node2D/Configuration"
	AudioServer.capture_set_device(config.audioDevice)
	_on_ReloadButton_pressed()
	
func _on_MicrophoneDropdown_item_selected(index):
	var name = get_item_text(index)
	AudioServer.capture_set_device(name)
	config.audioDevice = name
	config.save()

func _on_ReloadButton_pressed():
	clear()
	var i = 0
	for device in AudioServer.capture_get_device_list():
		add_item(device)
		if (device == config.audioDevice):
			select(i)
		i += 1
