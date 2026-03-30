f = Scale

if is_nan(compilationstartframe) compilationstartframe = 0
boundsoffset = lightboundsoffset
if darkmode boundsoffset = darkboundsoffset

scr_updateinput()
// SURVEY_PROGRAM_WINDOWS_ENGLISH.EXE
directorychangebuffer--

var label = string_hash_to_newline("DELTARUNE TEXTBOX - " + toptext)
draw_set_color(c_white)
draw_set_font(asset_get_index(topfont))
draw_text(labelx, labely, label)

labelx = 2
labely = -6

window_set_caption(label)
draw_set_font(fnt_mainbig)

__backingalpha = mtd_getsetting("backingalpha", darkmode) * 100
__backingoffsetx = mtd_getsetting("backingxoff", -1)
__backingoffsety = mtd_getsetting("backingyoff", -1)

if __backingoffsetx == -1 if darkmode __backingoffsetx = 1 else __backingoffsetx = 2
if __backingoffsety == -1 if darkmode __backingoffsety = 1 else __backingoffsety = 2
topfont = "fnt_mainbig"
switch string_lower(currentdirectory) {
	default:
	case "main": {
	boxvisible = true
	toptext = "Display"
	options = [
		{name:"Face",					func: function(){ mtd_changedirectory("faces") }											},
		{name:"Font",					func: function(){ mtd_changedirectory("fonts") }											},
		{name:"Text",					func: function(){ text = get_string("Insert the String you prefer, use \"&\" or \"#\" as Linebreaks", text)	}	},
		{name:"Generate Box",			func: function(){ scr_generate(
			get_string("GIVE IT THE FILENAME YOU PREFER", "NEWTEXTBOX" + (darkmode ? "_DARK" : "_LIGHT")), animated ? (sprite_get_number(spr_textbox_topleft) - 1) : 1, compilationstartframe) }														},
		{name:"Config",	func: function(){ mtd_changedirectory("settings") }																				},
		{name:"DarkModeToggle",			func: function(){ darkmode = !darkmode }																																								},
	]
	
	if scr_debug() {
		array_push(options, 
		{name: "RestartWithDebugLaunchArguments", func: function() {
			var params = "-game \"" + global.gamechangeinput + "\" -generate DELTABOXTEST -text \"* This is a “Text“!&&TestaRune\" -face \"__temppfp_debugtest.png\" -rescale 2 -writerdat \" " + string_replace_all(json_stringify({_spacingwidth:8,_spacingheight:18}), "\"", "'") + "\" -darkbox"
			show_debug_message(params)
			game_change("", params)}
			
		})	
	}
	
	var startx = 77
	var starty = 52
	_basemenuoptiondrawer(startx, starty)
	_basemenuheartmove()
	} break
	case "settings" : {
	boxvisible = DrawBoxInConfig
	toptext = "Config & Control#{Press [X] to Return}"
	options = [ 
		{name: "DrawBoxInConfigToggle",					func: function() { DrawBoxInConfig = !DrawBoxInConfig }},
		{name: "BoxWidth:" + string(boxwidth),			func: function() { boxwidth = get_integer("BoxWidth", boxwidth) }},
		{name: "BoxHeight:" + string(boxheight),		func: function() { boxheight = get_integer("BoxWidth", boxheight) }},
		
		// Mono [Regions don't work in here lol]
		{name: "MonoToggle",							func: function() { autospace = !autospace }
		}, 
		{active: !autospace, name: "Mono Spacing Horizontal: " + string(spacingwidth),	func: function() { spacingwidth =  get_integer("Spacingwidth, Typer Hspace Argument",  spacingwidth) }},
		{active: !autospace, name: "Mono Spacing Vertical: " + string(spacingheight),	func: function() { spacingheight = get_integer("Spacingheight, Typer Vspace Argument", spacingheight) }},
		
		// Backing
		{name: "Clear Backing Value Overrides", func: function() {
			mtd_clearsettings([
			"darkbacking",
			"backingalpha",
			"backingxoff",
			"backingyoff",
			])
			}},
		{name: "BackingAlphaAutoChangeToggleOverride",	func: function() { 
			if !variable_struct_exists(global.settingsoverride, "darkbacking")  global.settingsoverride.darkbacking = darkmode
				global.settingsoverride.darkbacking = !global.settingsoverride.darkbacking
			}},
		{name: "StartingBackingAlphaOverride: " + string(__backingalpha) + string("%"),	func: function() { 
				//mtd_readysetting("backingalpha", real(!darkmode))
				mtd_setsetting("backingalpha", get_integer("Alpha Range of 0-100, Mainly because \"get_integer\" makes me think you can't include decimals", __backingalpha) / 100)
			}},
		{name: "BackingXOffset: " + string(__backingoffsetx),				func: function() {mtd_setsetting("backingxoff", get_integer("Pretty obvious, Isn't it?", __backingoffsetx))}},
		{name: "BackingYOffset: " + string(__backingoffsety),				func: function() {mtd_setsetting("backingyoff", get_integer("Pretty obvious, Isn't it?", __backingoffsety))}},
		{name: "Fix Face Offsets " + string(fixoffsets),					func: function() { fixoffsets = !fixoffsets	}},
		{name: "GIFCOMPILATION " + string(animated),						func: function() { animated = !animated			}},
		{name: "DarkboxCompilationFrame " + string(compilationstartframe),	func: function() { compilationstartframe = (compilationstartframe + 1) % sprite_get_number(spr_textbox_topleft)	}},
		{name: "Scale " + string(Scale),	func: function() { Scale = clamp((Scale + 1) % 3, 1, Scale+2)	}},
		{name: "IMPORTCUSTOMWRITERDATA " + string(global.settingsoverride),	func: function() { 
			customargument_writerdata = global.settingsoverride
			___processcustomwriterdata(get_string("GIVE IT IN JSON FORMATTING.", json_stringify(customargument_writerdata))) 
			global.settingsoverride = customargument_writerdata
			}},
	]
	
	var startx = 77
	var starty = 52
	_basemenuoptiondrawer(startx, starty, _basemenuoptiongetoffset(options, heartpos))
		
	_basemenuheartmove()
		
	break }
	case "faces" : {
		// {realname: internalname, name: truename}
		topfont = "fnt_ja_mainbig"
		toptext = "FACES & EMOTION"
		var optionnumberfunc = function(option) {emotion = option.value}
		var optionsleft = []
		var optionsright = [{name: "0", value: 0, func: optionnumberfunc}]
		if asset_get_index("spr_face_" + face) != -1
		repeat (sprite_get_number(asset_get_index("spr_face_" + face)) - 1) {
			array_push(optionsright, 
			{ name: string(array_length(optionsright)), value: array_length(optionsright), func: optionnumberfunc }
			)
		}
		var facesprites = scr_getfacesprites()
		array_insert(facesprites, 0, {name: "No one", realname: "noone"})
		for (var i = 0; i < array_length(facesprites); ++i) {
			var data = facesprites[i]
			data.active = true
			data.func = function(option) {
				face = option.realname
			}
			if face == data.realname {
				data.primarycolor = c_aqua
				data.selectedcolor = #8FFF8C
			}
			array_push(optionsleft, data)
		}
		
		var menuy = _basemenuoptiongetoffset(options, heartpos)
		var startx = 50
		var starty = 52
		options = heartxpos == 0 ? optionsleft : optionsright
		_basemenuoptiondrawer(startx, starty, menuy, optionsleft, heartxpos == 0)
		draw_set_halign(fa_right)
		_basemenuoptiondrawer(room_width - startx, starty, menuy, optionsright, heartxpos == 1, function(option) {return [16, (string_height(option.name) / 2) + 1]})
		
		#region Heart
		var heartmoved = false
		var heartposprev = heartpos
		var heartxposprev = heartxpos
			if press_d heartpos++
			if press_u heartpos--
			if press_r heartxpos++
			if press_l heartxpos--
			heartxpos = mtd_wrap(heartxpos, 0, 1)
			heartpos = mtd_wrap(heartpos, 0, array_length(options) - 1)
			heartmoved = (heartpos != heartposprev) || heartxpos != heartxposprev
			if heartmoved mtd_play(snd_menumove)
			
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
			
		#endregion
	} break
	case "fonts" : {
		topfont = "fnt_ja_kakugo"
		toptext = "INTERNALSYSTEM/FONTS/" + string(font)
	
		labely = 2
		labelx = 2
		
		options = []
		var i = 0
		while font_exists(i) {
			array_push(options, {name: font_get_name(i), func: function(option) {font = option.name}})	
			i++
		}
		
		array_sort(options, function(a, b) {
			var a_name = string_replace(a.name, "fnt_", "")
			var b_name = string_replace(b.name, "fnt_", "")
			return ord(a_name) - ord(b_name)
		})
		
		var startx = 77
		var starty = 52
		_basemenuoptiondrawer(startx, starty, _basemenuoptiongetoffset(options, heartpos))
		_basemenuheartmove()
	}
}

draw_set_halign(fa_left)
gpu_set_blendmode(bm_subtract)
draw_rectangle_color(-10, room_height - 100, room_width, room_height, c_black, c_black, c_white, c_white, false)
gpu_set_blendmode(bm_normal)
if boxvisible {
	var visx = boxdrawx - ((boxwidth*f) / 2)
	var visy = boxdrawy - ((boxheight*f) / 2)
	scr_drawbox(visx, visy)//boxdrawx - (boxwidth / 2), boxdrawy - (boxheight / 2))
}
