//@desc Converts Hex to String, Doesn't Require 0x
function hex_to_number(hex){
	while string_length(hex) < 2
		hex = hex + "0"
	return real("0x" + string(hex))
}

/// @desc 
function shader_set_safe(shader){
	shader_reset()
	if shader < 0 || !shader_is_compiled(shader)
		return noone
	else
		return shader_set(shader)
}

function draw_text_writerstyle(x, y, str = "PLACEHOLDER", darkmode = false, spacing = -1, startmethod = -1, prestrsplit = -1){
	CONTROLLER = self
	with {} {
		var conversions_input = ["“"]
		var conversions_output = ["\""]
		for (i = 0; i < array_length(conversions_input); ++i) { str = string_replace_all(str, conversions_input[i], conversions_output[i]) }
		__callmethod = function(methodname) {
			if is_method(methodname) method(self, methodname)(other) else if script_exists(methodname) methodname(other)
		}
		__createmarkdowncode = function(initcode = "0", mtd = function() { return false}, override = false) {if variable_struct_exists(___textcodes, initcode) && !override return false else return variable_struct_set(___textcodes, initcode, mtd)}
		___textcodes = {}
		__createmarkdowncode("c", function() {
						i++
						istart = i
						letter = string_char_at(_str, i)
						nextletter = string_char_at(_str, i + 1)
						i++
						//show_debug_message("Color: {0}", nextletter)
						switch nextletter {
							default: i = istart	// Technically this behavior isn't in normal Deltarune...
							// CHAPTER 1+
							break case "R": drawcol = c_red
							break case "B": drawcol = c_blue
							break case "Y": drawcol = c_yellow
							break case "G": drawcol = c_green
							break case "W": drawcol = c_white
							break case "X": drawcol = c_black
							break case "0": drawcol = draw_originalcolor
							
							// CHAPTER 2+
							break case "P": drawcol = c_purple
							break case "M": drawcol = c_maroon
							
							break case "S": drawcol = #FF80FF 
							break case "V": drawcol = #80FF80 
							
							break case "I": drawcol = #81C0FF	// Chapter 3 Only.
							
							// CHAPTER 4+
							break case "O": drawcol = c_orange 
							break case "A": drawcol = #00AEFF 
							
							// CUSTOM
							break case "[": 
							i++
							letter = string_char_at(_str, i)
							nextletter = string_char_at(_str, i + 1)
							var _type = -1
							var offset = 1
							
							var readstart = i
							var readstring = ""
							var _i = 0
							var _nextletter = ""
							var readpos = i
							var endedproperly = false
							for (readpos = readstart; readpos <= string_length(_str); ++readpos) {
								_nextletter = string_char_at(_str, readpos)
								if _nextletter == "]" {endedproperly = true break}
							    readstring += _nextletter
							}
							
							if endedproperly {
								var __nextletters = {
								}
								
								variable_struct_set(__nextletters, "#", 1)
								variable_struct_set(__nextletters, "0x", 2)
								variable_struct_set(__nextletters, "$", 2)
								variable_struct_set(__nextletters, "hsv", 3)
							
								var _nextletterslist = variable_struct_get_names(__nextletters)
							
								array_sort(_nextletterslist, function(current, next) {
									var currentstr = string(current)	
									var nextstr = string(next)	
									return string_length(nextstr) - string_length(currentstr)
								})
							
								for (var current_letter = 0; current_letter < array_length(_nextletterslist); current_letter++) {
									var _letter = _nextletterslist[current_letter]
								    if string_starts_with(readstring, _letter) {
										readstring = string_delete(readstring, 1, string_length(_letter))
										_type = variable_struct_get(__nextletters, _letter)
										break
									}
								}
							}
							switch _type {
								// Nothing. (Ignores & Resets so the rest just gets drawn.)
								default: readpos = istart
								
								// HEX
								break case 1: {
									var _hexcolorfunction_normaldeltarune = function(hex) {
										return ((hex & 255) << 16) | (hex & 65280) | ((hex >> 16) & 255);
									}

									drawcol = _hexcolorfunction_normaldeltarune(real("0x" + readstring))
								}
								// Raw
								break case 2: drawcol = real("0x" + readstring)
								// HSV
								break case 3:
									var _hsvValues = []
									for (var jj = 1; jj < string_length(readstring); jj += 2) {
									    array_push(_hsvValues, string_char_at(readstring, jj) + string_char_at(readstring, jj+1))
									}
									var hsv_raw = real("0x" + readstring)
									var hsv_h = real("0x" + _hsvValues[0])
									var hsv_s = real("0x" + _hsvValues[1])
									var hsv_v = real("0x" + _hsvValues[2])
									//show_debug_message(make_colour_hsv(hsv_h, hsv_s, hsv_v))
									drawcol = make_colour_hsv(hsv_h, hsv_s, hsv_v)
									//show_debug_message(drawcol)
								break
							}
							i = readpos
							break
						}	
		})
		aligny = draw_get_valign()
		alignx = draw_get_halign()
		_x = x
		_y = y
		darkbacking = darkmode
		backingalpha = darkmode
		backingxoff = 1
		backingyoff = 1
		if !darkmode {
			backingxoff = 2
			backingyoff = 2	
		}
		if !variable_global_exists("ΔΔcustomwritertimerΔΔ") variable_global_set("ΔΔcustomwritertimerΔΔ", 0)
		var _timer = variable_global_get("ΔΔcustomwritertimerΔΔ")
		variable_global_set("ΔΔcustomwritertimerΔΔ", _timer + 1)
		_str = string_replace_all(string_hash_to_newline(str), "&", "\n")
		height = string_height(_str)
		width = string_width(_str)
		autosize = true
		_spacingwidth = spacing
		_spacingheight = spacing
		if spacing != -1 autosize = false
		
		if aligny == fa_bottom _y -= height
		if aligny == fa_center _y -= height / 2
		var originalshader = shader_current()
		var shader = originalshader
		if width > 0 && height > 0 {
		draw_set_halign(fa_left)
		draw_set_valign(fa_top)
		drawcol = draw_get_color()
		draw_originalcolor = drawcol
		
		_getstringwidth = function(ltr = "W") {
			if !autosize
				return _spacingwidth * string_length(ltr)
			else 
				return string_width(ltr)
		}
		
		newlinestartmethod = function() {}
		predrawmethod = function() {}
		preletter = function() {}
		drawletter = function() {
						draw_text_color(_x + backingxoff, _y + backingyoff, chr(dat.data), backing_col2, backing_col2, backing_col1, backing_col1, backingalpha)				
						draw_text_color(_x, _y, chr(dat.data), primary_col2, primary_col2, primary_col1, primary_col1, 1)
					}
		postletter = function() {}
		__callmethod(startmethod)
		
		draw = []
		_disablenextformatting = false
		/*
		=============================
		Type 0: Letter
		data: ord({Letter})
		=============================
		Type 1: Color
		data: ColorValue {ex, 255}
		=============================
		Type 2: Shader
		data: 00 To FF
		=============================
		*/
		_str_postformat = ""
		_str_postformat_assignments = []
		i = 1
		while i <= string_length(_str) {	
			var drawcolprev = drawcol
			var shaderprevious = shader
			_customdraw = -1
			_customdraw_additional = -1
			letter = string_char_at(_str, i)
			if (_disablenextformatting != i) {
			skipdraw = true
			switch letter {
				case "\\":
				_disablenextformatting = i + 1
				nextletter = string_char_at(_str, i + 1)
				if variable_struct_exists(___textcodes, nextletter) {
					method(self, variable_struct_get(___textcodes, nextletter))()
				} else skipdraw = false
				switch nextletter {
				case "s":
					i++
					letter = string_char_at(_str, i)
					var hexcode = string(string_char_at(_str, i + 1)) + string(string_char_at(_str, i + 2))
					var shaderid = hex_to_number(hexcode) - 1
					i += 2
					shader = shaderid
					if shader == -1 shader = originalshader
				break
				}
				break
				default:
				skipdraw = false
				break
			}
			}
			
			if drawcol != drawcolprev {
				var cols = {}
				cols.type = 1
				cols.data = drawcol
				array_push(draw, cols)
			}
			
			if shader != shaderprevious {
				var shd = {}
				shd.type = 2
				shd.data = shader
				array_push(draw, shd)
			}
			
			if is_method(_customdraw) || script_exists(_customdraw) {
				var scpt = {}
				scpt.type = -1
				scpt.data = [_customdraw, _customdraw_additional]
				array_push(draw, scpt)
			}
			
			if skipdraw != true {
				var ltr = {}
				ltr.type = 0
				ltr.data = ord(letter)
				_str_postformat = _str_postformat + letter
				array_push(_str_postformat_assignments, array_length(draw))
				array_push(draw, ltr)
			}
			
			i++
		}
		
		__callmethod(prestrsplit)
		
		strsplit = string_split(_str_postformat, "\n", false)
		i2 = 0
	
		backing_col1_default = c_navy
		backing_col2_default = c_dkgray
	
		backing_col1 = backing_col1_default
		backing_col2 = backing_col2_default
	
		primary_col1_default = draw_originalcolor
		primary_col2_default = draw_originalcolor
	
		primary_col1 = primary_col1_default
		primary_col2 = primary_col2_default
		
		//if is_method(startmethod) method(self, startmethod)(other)
	
		_line = false
		_startpoint = 0
		_originalx = x
		var _createlinebreak = function() {
				_x = _originalx
				ychange = string_height(strsplit[i2])
				if !autosize {
					ychange = _spacingheight
				}
				__callmethod(newlinestartmethod)
				_y += ychange
		}
		repeat array_length(strsplit) {
			_x = _originalx
			if _line { _createlinebreak() }
			_line = true
			_str = string(strsplit[i2])
			_str_postformat = _str
			__callmethod(predrawmethod)
			if alignx == fa_center {
				xchange = string_width(_str_postformat)
				if !autosize {
					xchange = _spacingwidth * string_length(_str_postformat)
				}
				_x -= xchange / 2
			}
			if alignx == fa_right {
				xchange = string_width(_str_postformat)
				if !autosize xchange = _spacingwidth * string_length(_str_postformat)
				_x -= xchange
			}
			var newshader = noone
			disabledrawdat = false
			i = _startpoint
			while i < array_length(draw) {
				dat = draw[i]
				//logargs(dat)
				if dat.type == 1 {
					primary_col1 = dat.data
					primary_col2 = dat.data 
					backing_col2 = dat.data
					backing_col1 = dat.data
			
					var defaultmode = (dat.data == c_white || dat.data == c_black)
					if darkbacking {
						backingalpha = 0.3
						if defaultmode backingalpha = 1
					}
					if darkmode && dat.data != c_black primary_col2 = c_white
					if defaultmode {
						backing_col1 = backing_col1_default
						backing_col2 = backing_col2_default
					}
					//draw_set_color(dat.data)
				}
				if dat.type == 0 {
					if chr(dat.data) == "\n" { _startpoint = i + 1 break}
					__callmethod(preletter)
					if !disabledrawdat {
						__callmethod(drawletter)
					}
					__callmethod(postletter)
			
					var xchange = string_width(chr(dat.data))
					if !autosize xchange = _spacingwidth
					_x += xchange
				}
				if dat.type == 2 {
					var shdreturn = shader_set_safe(dat.data)
					if shdreturn != noone
					{
						//logargs(_timer)
						newshader = dat.data
					}
				}
				if dat.type == -1 {
					var scpt = dat.data[0]
					_customdraw_additional = dat.data[1]
					if script_exists(scpt) || is_method(scpt) {
						__callmethod(scpt)
					}
				}
				if newshader != noone {
					shader_set_uniform_i(shader_get_uniform(newshader, "ShaderTimer"), _timer)
					shader_set_uniform_i(shader_get_uniform(newshader, "random"), round(random_range(0, c_white)))
				}
				i++
				}
			i2++
			}
		}
		shader_set_safe(originalshader)
		draw_set_halign(alignx)
		draw_set_valign(aligny)
	}
}