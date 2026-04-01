debugmode = true
fixoffsets = false

writer_addspecialsymbolsthatdontexistindeltarunewriter = false

compilationstartframe = 0
animated = false

if !script_exists(asset_get_index("camerax")) {
	camerax = function() {return 0}
	cameray = function() {return 0}
}

darkboundsoffset = 3 + 4
lightboundsoffset = 3

//function scr_facechoice()
//{
//	myface = instance_create(writer.x + (8 * f), writer.y + (5 * f), obj_face)
//}

textxoff = 0
textyoff = 0

Scale = 2

global.settingsoverride = {}

darkmode = false

heartpos_saved = {}

text = 
@"* WRITE THE TEXT THAT &\cRYOU\cW D E S I R E."
/*@"* \cBKRIS\cR, WHERE THE HELL ARE WE!!!!\c0
* Also, \cBglobal.truename\cR, Fix 
the Spacing of this \cYText\cR."*/
face = "noone"
emotion = 0
spacingwidth = 16
spacingheight = 36
autospace = false
font = "fnt_mainbig"

mtd_clearsettings = function(settingsarray) {
	try {
	for (var i = 0; i < array_length(settingsarray); ++i) variable_struct_remove(global.settingsoverride, settingsarray[i])
	} catch(ex) {}
}

mtd_setsetting = function(settingname, value = NaN) {
	try {
	return variable_struct_set(global.settingsoverride, settingname, value)
	} catch(ex) {}
}

mtd_readysetting = function(settingname, def = -1) {
	try {
	mtd_setsetting(settingname, mtd_getsetting(settingname, def))
	} catch(ex) {}
}

mtd_getsetting = function(settingname, def = -1) {
	try {
	if variable_struct_exists(global.settingsoverride, settingname) 
		return variable_struct_get(global.settingsoverride, settingname)
	return def
	} catch(ex) {}
}

boxwidth = 283
boxheight = 70
boxdrawx = room_width/2 //20 + (564 / 2)
boxdrawy = 304 + (138 / 2)
boxvisible = true

//darksized = false
//font = "fnt_main"

//	/*
//	578
//	152
//	*/
//boxwidth = 578 / 2
//boxheight = 152 / 2
//spacingwidth /= 2
//spacingheight /= 2

directorychangebuffer = 0

heartxpos = 0

_basemenuheartmove = function() {
	try {
	#region HeartMove
	var heartposprev = heartpos
	if press_d	heartpos++
	if press_u	heartpos--
	
	heartonpage = heartpos >= 0 && heartpos < array_length(options)
	
	if variable_struct_exists(self, "heartxpos") && variable_struct_exists(self, "heartxposend") {
		if press_r heartxpos++
		if press_l heartxpos--
	}
	if press_2	{
		if mtd_changedirectory("main") {
			mtd_play(snd_smallswing)
		}
	}
	
	if heartonpage {
		if press_1 {
			mtd_play(snd_select)	
			method(self, options[heartpos].func)(options[heartpos])
		}
	}
	
	heartpos = mtd_wrap(heartpos, 0, array_length(options) - 1)
	
	//heartpos = heartpos % array_length(options)
	//heartpos = array_length(options)-1 - (((array_length(options) - 1) - heartpos) % (array_length(options)))
	if heartposprev != heartpos mtd_play(snd_menumove)
	#endregion
	}
	catch (ex) { 
		if debugmode show_message(ex)
		return ex
	}
	return true
}

_basemenuoptiondrawer = function(startx, starty, optionoffset = 0, _options = options, hearthere = true, heartoffsetfunc = function(option) {return [-16, (string_height(option.name) / 2) + 1]}) {
	try {
		var _x = startx
		var _y = starty
	
		for (var i = optionoffset; i < array_length(_options); ++i) {
			var option = _options[i]
			var primarycolor = c_white
			var selectedcolor = c_yellow
			var disabledmergecolor = c_black
			if variable_struct_exists(option, "primarycolor") primarycolor = option.primarycolor
			if variable_struct_exists(option, "selectedcolor") selectedcolor = option.selectedcolor
			draw_set_color(primarycolor)
			if i == heartpos && hearthere {
				draw_set_color(selectedcolor)
				var getheartpos = heartoffsetfunc(option)
				draw_sprite(spr_heart_centered, 0, _x + getheartpos[0], _y + getheartpos[1])
			}
			
			if variable_struct_exists(option, "active") 
			if option.active = false 
			draw_set_color(merge_color(draw_get_color(), disabledmergecolor, 0.5))
		
			draw_text(_x, _y, option.name)
			_y += string_height(option.name)
		}
	}
	catch (ex) {
		if debugmode show_message(ex)
		return ex
	}
	return true
}

_basemenuoptiongetoffset = function(options, heartpos) {
	var lowestheartpos = 8
	var farthestheartpos = 6*2
	if boxvisible lowestheartpos = 6
	if array_length(options) < farthestheartpos farthestheartpos = array_length(options) - 1	
	return clamp(heartpos - lowestheartpos, 0, (boxvisible || array_length(options) <= lowestheartpos) ? heartpos : (array_length(options) - farthestheartpos))
}

DrawBoxInConfig = false

hasmultipleframes = false
cur_jewel = 0

mtd_choose_array = function(arr) {
	return arr[random(array_length(arr) - 1)]
}

var berdlyoptions = ["Frozen Chicken", "Burgerly", "Berdly"]
repeat 5 array_push(berdlyoptions, "Berdly")

facespriteinternalnames = {
	#region Ralsei
		"r_nohat":"Ralsei Hatless",
		"r_hood":"Ralsei Hood",
		"r_dark":"Ralsei Dark",
	#endregion
		"placeholder":"DR Placeholder Face.",
	#region Holidays
		"n_matome":"Noelle Holiday",
		"carol":"Carol Holiday",
		"rudy": "Rudy Holiday",
	#endregion
		"berdly": mtd_choose_array(berdlyoptions),
		"rurus":"Rouxls Karrd",
		"susie_alt": "Susie",
		"l0": "Lancer",
		"catty": "Catty",
		"undyne": "Undyne",
		"bratty": "Bratty",
		"king": "King",
		"queen": "Queen",
		"burgerpants": "Pants [Burger Edition]",
		"asgore": "Asgore [Sprites Combined]",
		"sans": "sans [combined]",
	}

_checkforifblacklisted = function(sprite) {
	var fblist = FACEBLACKLIST
	for (var j = 0; j < array_length(fblist); ++j) { if fblist[j] == sprite { return true} }
	return false
}

scr_getfacesprites = function() {
	var i = 0
	var sprites = []
	while sprite_exists(i) {
		var sprname = sprite_get_name(i)
		if _checkforifblacklisted(i) sprname = "[FACEBLACKLISTED]"
		if string_starts_with(sprname, "spr_face_") {
			var internalname = string_replace(sprname, "spr_face_", "")	
			var truename = "CustomFaceSprite | " + string(internalname)
			if variable_struct_exists(facespriteinternalnames, internalname) 
				truename = variable_struct_get(facespriteinternalnames, internalname)
				
			array_push(sprites, {realname: internalname, name: truename})
		}
		i++
	}
	return sprites
}

scr_generate = function(fname, frames = 1, startframe = 0) {
	f = Scale
	boundsoffset = lightboundsoffset
	if darkmode boundsoffset = darkboundsoffset
	var surfwidth = boxwidth*f + boundsoffset*f*2
	var surfheight = boxheight*f + boundsoffset*f*2
	show_debug_message(surfwidth)
	show_debug_message(surfheight)
	show_debug_message(f)
	//if darkmode frames = sprite_get_number(spr_textbox_topleft) - 1
	var makegif = false
	//frames = 1
	//codecomment_decompilable = "I'm getting annoyed with GameMaker's gif thing, because this isn't animating, So I'm disabling gif export."
	if frames > 1 makegif = true 
	
	if makegif gif = gif_open(surfwidth, surfheight, c_red)
	var surf = surface_create(surfwidth, surfheight)
	if scr_debug() show_message("GENERATIONSURFACECREATED\nWidth: " + string(surface_get_width(surf)) + "\nHeight: " + string(surface_get_height(surf)))
	surface_set_target(surf)
	var jewelold = cur_jewel
	cur_jewel = 0
	var __frame = startframe
	repeat frames {
		__frame++
		draw_clear_alpha(0, 0)
		cur_jewel = ((__frame - 1) << 1) + ((__frame - 1) << 3)// * 10
		scr_drawbox(boundsoffset*f, boundsoffset*f)
		draw_flush()
		if makegif gif_add_surface(gif, surf, (1/(room_speed / 10))*100, 0, 0, 3)
	}
	cur_jewel = jewelold
	surface_reset_target()
	var fnamepath = scr_getsavedir(fname)
	if scr_debug() show_message(fnamepath)
	if makegif
		gif_save(gif, fnamepath + ".gif")
	else
		surface_save(surf, fnamepath + ".png")
	surface_free(surf)
}

scr_drawbox = function(x, y) {
	draw_set_alpha(1)
	var dboxargument_width = (boxwidth - real(darkmode))
	var dboxargument_height = (boxheight - real(darkmode))
	scr_dbox(darkmode, false, x, y, dboxargument_width, dboxargument_height, Scale - 1)
	
	draw_set_font(asset_get_index(font))
	draw_set_color(c_white)
	// writer.x + (8 * f), writer.y + (5 * f)
	
	basetextx = round(x + 10 * f)
	basetexty = round(y + (5 + 2) * f)
	
	xoff = textxoff
	yoff = textyoff
	
	var facespr = asset_get_index("spr_face_" + string(face))
	var isfaceasset = false
	if is_real(face) {
		facespr = face
		isfaceasset = true
	}
	if _checkforifblacklisted(facespr) { facespr = -1 }
	var facespriteoffset = scr_facegetoffset(face, fixoffsets)
	var changexfaceoffpos = 8 * f
	var changeyfaceoffpos = 5 * f
	
	if f > (real(darkmode) + 1) || fixoffsets {
		facespriteoffset[0]	*= f
		facespriteoffset[1]	*= f
	}
	
	facespriteoffset[0]	+= changexfaceoffpos
	facespriteoffset[1]	+= changeyfaceoffpos
	
	if sprite_exists(facespr) {
		xoff += (58 * f)
		if isfaceasset {
			draw_sprite_stretched(facespr, emotion, basetextx - 6*f, basetexty - 3*f, 60*f, 60*f)
		} else draw_sprite_ext(facespr, emotion, basetextx + facespriteoffset[0], basetexty + facespriteoffset[1], f, f, 0, c_white, 1)
	}
	
	draw_text_writerstyle(xoff + basetextx, yoff + basetexty, string(text), darkmode, undefined, function(me) {
		CONTROLLER = me
		
		__createmarkdowncode("I", function() {
			i += 2
			letter = string_char_at(_str, i)
			try {
				if string_digits(letter) == letter {
					_customdraw_additional = real(letter)
				
					_customdraw = function() {
					
					}
				} else i--
			}
		})
		
		__createmarkdowncode("F", function() {
				i += 2
				letter = string_char_at(_str, i)
				
				var __face = CONTROLLER.face
				
				switch letter {
					case "0": __face = "noone" break
					case "S": __face = "susie_alt" break
					case "R": __face = "r_nohat" break
					case "N": __face = "n_matome" break // Noelle
					case "T": __face = "toriel" break
					case "L": __face = "l0" break
					case "s": __face = "sans" break
					case "A": __face = "asgore" break
					case "a": __face = "spr_alphysface" break
					case "B": __face = "berdly" break
					case "b": __face = "burgerpants" break
					case "r": __face = "rudy" break
					case "u": __face = "rurus" break
					case "U": __face = "undyne" break
					case "K": __face = "king" break
					case "Q": __face = "queen" break
					case "C": __face = "carol" break
					case "y": __face = "bratty" break
					case "i": __face = "catti" break
				}
				
				CONTROLLER.face = __face
		})
		
		__createmarkdowncode("E", function() {
			i += 2
			nextchar2 = string_char_at(_str, i)
			global.fe = CONTROLLER.emotion
			__nextface = ord(nextchar2)
			
			if (__nextface >= 48 && __nextface <= 57)
				global.fe = real(nextchar2)
			else if (__nextface >= 65 && __nextface <= 90)
				global.fe = __nextface - 55
			else if (__nextface >= 97 && __nextface <= 122)
				global.fe = __nextface - 61
			CONTROLLER.emotion = global.fe
		})
		
		emojiforceautosize= true
		xoff_2 = 0
		predrawmethod = function(me) {
			var offsetme = true
			if string_starts_with(_str_postformat, "* ") {
				xoff_2 = _getstringwidth("* ")
				offsetme = false
			}
			if offsetme _x += xoff_2
			
			
		}
		
		preletter = function(me) {}
		postletter = function(me) {
			disabledrawdat = false
		}
		
		
		autosize = me.autospace
		_spacingwidth = me.spacingwidth
		_spacingheight = me.spacingheight
		
		var _settings = variable_struct_get_names(global.settingsoverride)
		for (var i = 0; i < array_length(_settings); ++i) variable_struct_set(self, _settings[i], variable_struct_get(global.settingsoverride, _settings[i]))
	
	}, function(me) { wrapamt = (me.boxwidth * me.Scale) - (me.xoff + me.basetextx) })
		
	gpu_set_blendmode(bm_add)
	draw_set_color(c_black)
	draw_rectangle(x, y, x + dboxargument_width * f, y + dboxargument_height * f, false)
	gpu_set_blendmode(bm_normal)
}

heartpos = 0
directoriesthatsaveheartpos = ["main"]
currentdirectory = ""
toptext = "GENERATE"
topfont = "fnt_mainbig"
labelx = 2
labely = -6

mtd_changedirectory = function(dname) {
	if currentdirectory == dname { mtd_play(snd_error) return false }
	for (var i = 0; i < array_length(directoriesthatsaveheartpos); ++i) {
		if currentdirectory == directoriesthatsaveheartpos[i] {
			variable_struct_set(heartpos_saved, currentdirectory, heartpos)
			break	
		}
	}
	directorychangebuffer = 3
	heartpos = 0
	var previousdir = currentdirectory
	if variable_struct_exists(heartpos_saved, dname) 
		heartpos = variable_struct_get(heartpos_saved, dname)
	currentdirectory = dname
	
	if variable_struct_exists(self, "__directorycreatescript_" + string(currentdirectory)) variable_struct_get(self, "__directorycreatescript_" + string(currentdirectory))(previousdir)
	return true
}

mtd_changedirectory("main")

scr_updateinput = function() {
	press_d = keyboard_check_pressed(vk_down)
	press_u = keyboard_check_pressed(vk_up)
	press_l = keyboard_check_pressed(vk_left)
	press_r = keyboard_check_pressed(vk_right)

	press_1 = keyboard_check_pressed(vk_enter)		|| keyboard_check_pressed(ord("Z"))
	press_2 = keyboard_check_pressed(vk_shift)		|| keyboard_check_pressed(ord("X"))
	press_3 = keyboard_check_pressed(vk_control)	|| keyboard_check_pressed(ord("C"))
}
scr_updateinput()

mtd_play = function(sound) {
	return audio_play_sound(sound, 600, false)	
}

mtd_wrap = function(value, _min, _max) {
	var __maxmod = (_max + 1 - _min)
	if __maxmod == 0 return 0
	value = value % __maxmod
	value = (_max - (_max - value) % __maxmod)
	return clamp(value, _min, _max)
}

images = [spr_heart_centered]

if scr_debug() show_message(global.launch_arguments)

if global.launch_arguments.customargument_settext != -1													text =					 (global.launch_arguments.customargument_settext)
if global.launch_arguments.customargument_setface != -1													{
	face =					 (global.launch_arguments.customargument_setface)
}
if global.launch_arguments.customargument_setemotion != -1												emotion =				 (global.launch_arguments.customargument_setemotion)
if global.launch_arguments.customargument_darkbox != -1													darkmode =				 (global.launch_arguments.customargument_darkbox)
if global.launch_arguments.customargument_scale != -1													Scale =				clamp(global.launch_arguments.customargument_scale, 0, 9999)
if global.launch_arguments.customargument_setwidth > 0													boxwidth =				 (global.launch_arguments.customargument_setwidth)
if global.launch_arguments.customargument_setheight > 0 || global.launch_arguments.customargument_setheight == -2				{
	if global.launch_arguments.customargument_setheight == -2 {
		_automaticallycalculateboxheight()
	} else boxheight = (global.launch_arguments.customargument_setheight)
}
if global.launch_arguments.customargument_setfont != -1													font =					 (global.launch_arguments.customargument_setfont)
if !is_nan(global.launch_arguments.customargument_darkboxframe)											compilationstartframe =  (global.launch_arguments.customargument_darkboxframe)
if array_length(variable_struct_get_names(global.launch_arguments.customargument_writerdata)) > 0		global.settingsoverride = global.launch_arguments.customargument_writerdata

if global.launch_arguments.customargument_autogenerate != false											scr_generate(global.launch_arguments.customargument_autogenerate, global.launch_arguments.customargument_frames, compilationstartframe)

if global.launch_arguments.customargument_autoquit {
	show_debug_message("AUTOQUITTING.")
	game_end()
}

_automaticallycalculateboxheight = function() {
	var lines = array_length(string_split_ext(text, ["\n", "&", "#"]))
	show_debug_message(lines)
	var stringheight = ((lines) * (spacingheight/Scale)) + (16)
	boxheight = clamp(stringheight, 70, 0xFFFFFF)
}