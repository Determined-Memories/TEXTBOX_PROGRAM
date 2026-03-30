global.falseloadingscreenactive = false

global.rewrittenmode = false

global.debug = __debugmacro
global.launch_arguments = (scr_init_launch_parameters())
global.debug = global.launch_arguments.debug

gpu_set_tex_filter(false)

var multiplier = 40

aspectminrescale = 160
width_aspect = 4
height_aspect = 3


var __widthaspect = width_aspect * aspectminrescale
var __heightaspect = height_aspect * aspectminrescale

width =  floor(ceil(display_get_width()  / (width_aspect/multiplier)) / __widthaspect) * __widthaspect
height = floor(ceil(display_get_height() / (height_aspect/multiplier)) / __heightaspect) * __heightaspect

var mtd_toobig = function() {
	return width > display_get_width() || height > display_get_height()
}
 
while mtd_toobig() {
	width /= clamp(multiplier / 2, 1, multiplier)
	height /= clamp(multiplier / 2, 1, multiplier)
}

width =  round(width / __widthaspect)*__widthaspect
height = round(height / __heightaspect)*__heightaspect

window_set_rectangle(display_get_width() / 2 - width/2, display_get_height() / 2 - height/2, width, height)

if global.launch_arguments.customargument_autoquit {
	window_set_rectangle(-666, -666, 1, 1)
	event_perform_object(obj_textbox, event_type, event_number)
	game_end()
	exit;
}

if global.falseloadingscreenactive 
	room_goto(DEVICE_FALSEINIT) 
else 
	room_goto(Room1)

with all {
	if variable_struct_get(self, "name") == "kris" || object_index == asset_get_index("obj_mainchara") || variable_struct_get(self, "dsprite") = asset_get_index("spr_krisd") || variable_struct_get(self, "dsprite") = asset_get_index("spr_krisd_dark")
	instance_destroy()
}