extends Node

var inputSpectrum
var inputVolume = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	inputSpectrum = AudioServer.get_bus_effect_instance(AudioServer.get_bus_index("Record"), 2)
	
	var miclist = AudioServer.capture_get_device_list()
	print("MICROPHONES:")
	for i in miclist:
		print("\t" + i)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	inputVolume = linear2db(inputSpectrum.get_magnitude_for_frequency_range(0, 20000, AudioEffectSpectrumAnalyzerInstance.MAGNITUDE_AVERAGE).length())
