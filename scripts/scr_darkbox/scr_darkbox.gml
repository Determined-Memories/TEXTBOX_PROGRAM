
function scr_darkbox(x1, y1, x2, y2, size = 2){
	if (!variable_instance_exists(id, "cur_jewel")) cur_jewel = 0
	if (!variable_global_exists("flag")) {
		global.flag[9999] = 0 // Sets 9999 Values to 0, as the other 9998 Values get defaulted to Zero.
	}
	
	cur_jewel += 1
	
	x1 = floor(x1)
	x2 = floor(x2)
	y1 = floor(y1)
	y2 = floor(y2)
	
	textbox_width = ceil(x2 - x1 - 31.5*size)
	if (textbox_width < 0) textbox_width = 0
	
	textbox_height = ceil(y2 - y1 - 31.5*size)
	if (textbox_height < 0) textbox_height = 0
	
	
	var __32scaled = 16*size
	
	var topspr		= darkboxtopsprite
	var leftspr		= darkboxleftsprite
	var topleftspr	= darkboxtopleftsprite
	
	if (textbox_width > 0) {
		draw_sprite_stretched(topspr, 0, x1 + __32scaled, y1, textbox_width, __32scaled)
		draw_sprite_ext(topspr, 0, x1 + __32scaled, y2 + 1, textbox_width, -size, 0, c_white, 1)
	}
	
	if (textbox_height > 0) {
		draw_sprite_ext(leftspr, 0, x2 + 1, y1 + __32scaled, -size, textbox_height, 0, c_white, 1)
		draw_sprite_ext(leftspr, 0, x1, y1 + __32scaled, size, textbox_height, 0, c_white, 1)
	}
	
	var frame = 0
	
	if global.flag[8] == false frame = cur_jewel / 10
	draw_sprite_ext(topleftspr, frame, x1,	 y1,	size,	size, 0, c_white, 1)
	draw_sprite_ext(topleftspr, frame, x2 + 1, y1,	-size,	size, 0, c_white, 1)
	draw_sprite_ext(topleftspr, frame, x1,	 y2 + 1, size, -size, 0, c_white, 1)
	draw_sprite_ext(topleftspr, frame, x2 + 1, y2 + 1, -size, -size, 0, c_white, 1)
}
