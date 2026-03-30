#macro OverrideParams false

function scr_init_launch_parameters(){
	var param_data = new launch_parameters()
	var param_extra = new launch_parameter_conversions()
	var p_num = parameter_count()
	
	if OverrideParams {
		if true {
			var param_overrides = ["text", "darkbox", "face", "boxheight", "images", "emotion", "generate"]
			var argument_overrides = [
			"* Lorem ipsum dolor sit#amet, consectetur#adipiscing elit, sed#do eiusmod tempor#incidunt ut labore et#dolore magna aliqua.#Ut enim ad minim#veniam, quis nostrum#exercitationem ullamco#laboriosam, nisi ut#aliquid ex ea commodi#consequatur. Duis aute#irure reprehenderit in#voluptate velit esse#cillum dolore eu#fugiat nulla pariatur.#Excepteur sint#obcaecat cupiditat non#proident, sunt in#culpa qui officia#deserunt mollit anim#id est laborum.#", 
			""/*Darkbox*/, "n_matome"/*Face*/, "a"/*boxheight (auto)*/, "__temppfp_debugtest.png,__tempimg_debugtest.png" /*INCOMPLETE*/, "10"/*Emotion*/, @"D:\Test\TEXTBOX\TESTBOX"/*Generate (PATH)*/]
			for (var i = 0; i < array_length(param_overrides); ++i) {
				paramname = param_overrides[i]
				_argument = argument_overrides[i]
				if variable_struct_exists(param_extra, paramname) {
					var __method = variable_struct_get(param_extra, paramname)
					if is_method(__method) || script_exists(__method) {
						if is_method(__method)
							method(param_data, __method)(_argument)
						else 
							__method(_argument)
					}
				}
			}
		}
	} else
	if (p_num > 0) for (var i = 0; i < p_num; i += 1) {
		var param = parameter_string(i + 1)
		var paramnext = parameter_string(i + 2)
		
		var _banish = function(paramnext) { 
			show_debug_message(paramnext)
			return string_ends_with(paramnext, "\"") && !string_ends_with(paramnext, "\\\"")
		}
		
		if string_starts_with(param, "-") {
			var _argument = ""
			if !string_starts_with(paramnext, "-") {
				_argument = paramnext
				if _banish(paramnext) {
					_argument = string_delete(paramnext, 1, 1)
					i++
					for (var a = 0; i < p_num && (!_banish(paramnext)); ++i) {
						var paramnext = parameter_string(i + 2)
						var add = paramnext
						if _banish(paramnext) add = string_delete(add, string_last_pos("\"", add), 1) 
						//else if string_ends_with(paramnext, "\\\"") add = string_delete(add, string_last_pos("\\\"", add) - 1, 1)
						_argument += " " + add
					}
				}
			}
		
			var paramname = string_delete(param, 1, 1)
			show_debug_message("Value: " + string(paramname) + "\nargument: " + string(_argument))
			
			if variable_struct_exists(param_extra, paramname) {
				var __method = variable_struct_get(param_extra, paramname)
				//show_debug_message(is_method(__method))
				//show_debug_message(typeof(__method))
				//show_debug_message(param_extra)
				try {
					if is_method(__method) || script_exists(__method) {
						if is_method(__method)
							method(param_data, __method)(_argument)
						else 
							__method(_argument)
					}
				} catch (ex) {
					show_debug_message("Error Occured on Launch Parameter '" + string(paramname) + "' with argument of '" + string(_argument) + "' Here is the longMessage, message, and stacktrace in this order")
					show_debug_message(ex.longMessage)
					show_debug_message(ex.message)
					show_debug_message(ex.stacktrace)
				}
			}
		}
		
		if (param == "launcher") param_data.is_launcher = true
		else if (string_pos("switch_", param) != 0) {
			var param_parts = string_split(param, "_")
			param_data.switch_id = real(param_parts[1])
		}
	}
	
	return param_data;
}
#macro __debugmacro false
#macro Debug:__debugmacro true
function launch_parameters() constructor {
	is_launcher = false
	switch_id = -1
	returning = false
	customargument_autoquit		= false
	customargument_autogenerate = false
	customargument_settext		= -1
	customargument_setface		= -1
	customargument_setface_isspriteasset = false
	customargument_setemotion	= -1
	customargument_darkbox		= -1
	customargument_setwidth		= -1
	customargument_setheight	= -1
	customargument_scale		= -1
	customargument_setfont		= -1
	customargument_frames		= 1
	customargument_darkboxframe = NaN
	customargument_writerdata	= {}
	customargument_images_mode = -1
	customargument_images = []
	camefromgamechangeorgms2test = false
	debug = __debugmacro
}

function get_chapter_switch_parameters(){
	var launch_data = new launch_parameters()
	launch_data.is_launcher = global.launcher
	
	/*if scr_is_switch_os() && variable_global_exists("switchlogin")
		launch_data.switch_id = global.switchlogin*/
	
	var parameters = []
	parameters[0] = "launcher"
	parameters[1] = "switch_" + string(launch_data.switch_id)
	parameters[2] = "returning_" + string(global.chapter)
	
	var param_formatted = ""
	
	for (var i = 0; i < array_length(parameters); i++) 
		param_formatted += (" " + string(parameters[i]))
	
	return param_formatted;
}
	
function ___processcustomwriterdata(input) {
	try {	customargument_writerdata = json_parse(input)	}	catch(ex) { if scr_debug() {show_message(customargument_writerdata) show_message(ex) show_message(input)} customargument_writerdata = {}}		
}

#macro facehttps_saveto working_directory + "temp_face.png"

function __processfaceinput(input) {
	show_debug_message("Processing Face Input")
	
	if file_exists(input) {
		var retrytimes = 0
		customargument_setface = sprite_add(input, 0, false, false, 0, 0)
		customargument_setface_isspriteasset = true
	}
	else {
		customargument_setface	= input
		customargument_setface_isspriteasset = false
	}
	
	show_debug_message(customargument_setface)
											
}

function __processinput_images(input) {
	var parsedinput = string_split(input, ",")
	if array_length(parsedinput) == 0 exit;
	customargument_images_mode = parsedinput[0]
	customargument_images = []
	for (var i = 1; i < array_length(parsedinput); ++i) {
		try {
			var fname = parsedinput[i]
		    array_push(customargument_images, sprite_add(fname, 0, 0, 0, 0, 0))
		} catch (ex) {
			show_message("ERROR, FILE (" + string(i) + "/" + string(array_length(parsedinput)) + ") HAD AN ERROR BEING ADDED IN LAUNCH PARAMETER PROCESSING, SKIPPING \n--------------------------------------------------\n" + string(ex.longMessage))
		}
	}
}

function launch_parameter_conversions() constructor {
											quit		=			function(input)		{	customargument_autoquit						= true															}
											generate	=			function(input)		{	customargument_autogenerate					= string(input)													}
											text		=			function(input)		{	if input != "" customargument_settext		= input															}
											face		=			function(input)		{	if input != "" __processfaceinput(input)																						}
											emotion		=			function(input)		{	if input != "" customargument_setemotion	= input															}
											darkbox		=			function(input)		{	customargument_darkbox = true	if string_digits(input) == input && input != "" customargument_darkboxframe = real(input)																			}
											boxwidth	=			function(input)		{	try { customargument_setwidth = real(input) } catch (ex) {}													}
											boxheight	=			function(input)		{	try { customargument_setheight = input == "a" ? -2 : real(input) } catch (ex) {}												}
											rescale		=			function(input)		{	try { customargument_scale = real(input) } catch (ex) {}													}
											font		=			function(input)		{	if input != "" customargument_setfont = input																}
											writerdat	=			___processcustomwriterdata
	/* Built in GameMaker, For Debugging */	game		=			function(input)		{	camefromgamechangeorgms2test = true	global.gamechangeinput = input																	}
											debug		=			function(input)		{	debug = true	global.debug = true																		}
											gif			=			function(input)		{	if input = "" customargument_frames = sprite_get_number(spr_textbox_topleft) - 1 else if string_digits(input) == input && real(input) > 1	customargument_frames = real(input)															}
											images		=			__processinput_images
}