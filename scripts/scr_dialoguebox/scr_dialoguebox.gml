function scr_dbox(dark = global.darkzone, autopos = true, _x = 19 * (real(global.darkzone) + 1), _y = 8 * (real(global.darkzone) + 1), width = 283, height = 70, darkscale = global.darkzone) {
	if !variable_instance_exists(id, "side") side = -1
	var f = real(darkscale) + 1
	
	xxx = 0
	yyy = 0
	var col = draw_get_color()
	if autopos {
		if side != 0 _y += 155 * f
		xxx = camerax()
		yyy = cameray()
	}
	
	var bordersize = 3 * f
	
	if dark bordersize += 4*f
		
	if (!dark) {
		//draw_sprite_ext(spr_pxwhite, 0, xxx + 16, yyy + 5 + off, 289, 76, 0, c_white, 1)
		//draw_sprite_ext(spr_pxwhite, 0, xxx + 19, yyy + 8 + off, 283, 70, 0, c_black, 1)
		draw_sprite_ext(spr_pxwhite, 0, xxx + _x - bordersize, yyy + _y - bordersize, width * f + bordersize*2, height * f + bordersize*2, 0, c_white, 1)
		draw_sprite_ext(spr_pxwhite, 0, xxx + _x, yyy + _y, width * f, height * f, 0, c_black, 1)
	}
	
	if (dark) {
		//if (side == 0) {
			draw_set_color(c_black)
			draw_rectangle(	xxx + _x,					yyy + _y, xxx + _x + width * f, yyy + _y + height * f, false)
			scr_darkbox(	(xxx + _x - bordersize), (	yyy + _y - bordersize), (xxx + _x + bordersize + width * f), (yyy + _y + bordersize + height * f), f)
		//} else {
		//	draw_set_color(c_black)
		//	draw_rectangle(xxx + 38, yyy + 326, xxx + 602, yyy + 464, false)
		//	scr_darkbox((xxx + 32) - 8, (yyy + 320) - 8, xxx + 608 + 8, yyy + 470 + 8)
		//}
	}
	
	draw_set_color(col)
}

function scr_dialoguebox() {
	var args = []
	for (var i = 0; i < argument_count; ++i) {
		array_push(args, argument[i])
	}
	return script_execute_ext(scr_dbox, args)
}