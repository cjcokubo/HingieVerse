extends Node3D

var i: XRInterface

func _ready() -> void:
	i = XRServer.find_interface("OpenXR")
	if i and i.is_initialized():
		print("OpenXR interface initialize")
		
		DisplayServer.window_set_vsync_mode(DisplayServer.VSYNC_DISABLED)
		
		get_viewport().use_xr = true
		
	else: 
		print("Interface not initialized")
