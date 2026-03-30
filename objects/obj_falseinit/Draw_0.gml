draw_sprite_ext(spr_heart_logo_prophecy, 0, x, y, image_xscale, image_yscale, 0, c_white, 1)

draw_set_font(fnt_main)
draw_set_halign(fa_center)
draw_text_writerstyle(x, y + 35, @"\WGATHERING \OTENSION POINTS&", true, undefined, function(myself) {
		__RENDEREROBJ = myself
		__createmarkdowncode("O", function() {
			i++
			drawcol = merge_color(c_orange, c_yellow, global.tension / global.maxtension)
			
		})	
		__createmarkdowncode("W", function() {
			i++
			strsplit[array_length(strsplit) - 1] += string(round(global.tension/global.maxtension*100)) + "%"
		})
})

global.tension += 0.25
