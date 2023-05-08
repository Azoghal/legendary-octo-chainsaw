extends Camera2D

# Define some minimums and maximums
# Define some mappings 

@export var camera_zoom_rate = 0.1
@export var window_resize_rate = 32
var zoom_vector = Vector2(camera_zoom_rate, camera_zoom_rate)
var resize_vector = Vector2i(window_resize_rate, window_resize_rate)
var reposition_vector = Vector2i(window_resize_rate/2,window_resize_rate/2)

var zoomIn = false
var zoomOut = false

var min_size = 144
var max_size = 816

var sizeZoomIndex = 4
var size_levels = [264,462,620,738,816]
var zoom_levels = [24./16., 22./16., 20./16., 18./16., 16./16.]

# Called when the node enters the scene tree for the first time.
func _ready():
	print(zoom_levels)
	pass # Replace with function body.

func _physics_process(delta):
	pass
#	if zoomIn:
#		var winsize = DisplayServer.window_get_size()
#		var winpos = DisplayServer.window_get_position()
#		if sizeZoomIndex < 4:
#			sizeZoomIndex += 1
#			zoom = Vector2(zoom_levels[sizeZoomIndex], zoom_levels[sizeZoomIndex])
#			var new_size = Vector2i(size_levels[sizeZoomIndex],size_levels[sizeZoomIndex])
#			var size_dif = new_size - winsize
#			DisplayServer.window_set_size(Vector2i(size_levels[sizeZoomIndex],size_levels[sizeZoomIndex]))
#			DisplayServer.window_set_position(winpos-(size_dif/2))
#		zoomIn = false
#	if zoomOut:
#		var winsize = DisplayServer.window_get_size()
#		var winpos = DisplayServer.window_get_position()
#		if sizeZoomIndex > 0:
#			sizeZoomIndex -= 1
#			zoom = Vector2(zoom_levels[sizeZoomIndex], zoom_levels[sizeZoomIndex])
#			var new_size = Vector2i(size_levels[sizeZoomIndex],size_levels[sizeZoomIndex])
#			var size_dif = winsize - new_size
#			DisplayServer.window_set_size(Vector2i(size_levels[sizeZoomIndex],size_levels[sizeZoomIndex]))
#			DisplayServer.window_set_position(winpos+(size_dif/2))
#		zoomOut = false



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
#	if Input.is_action_just_pressed("windowSizeXDec"):
#		var winsize = DisplayServer.window_get_size()
#		var winpos = DisplayServer.window_get_position()
#		#winsize -= Vector2i(resize_vector*delta)
#		if winsize[0] >= min_size + 32:
#			zoom = zoom + zoom_vector
#			winsize -= resize_vector
#			winpos += reposition_vector
#			DisplayServer.window_set_size(winsize)
#			DisplayServer.window_set_position(winpos)
#
#	if Input.is_action_just_pressed("windowSizeXInc"):
#		var winsize = DisplayServer.window_get_size()
#		var winpos = DisplayServer.window_get_position()
#		if winsize[0] <= max_size-32:
#			winsize += resize_vector
#			DisplayServer.window_set_size(winsize)
#			winpos -= reposition_vector
#			DisplayServer.window_set_position(winpos)
#
#
#	if Input.is_action_just_pressed("zoomIn"):
#		zoomIn = true
#
#	if Input.is_action_just_pressed("zoomOut"):
#		zoomOut = true

			

	
	# print("frame")
	# var winsize = DisplayServer.window_get_size()
	# print(winsize[0])
