function scr_facerender(emotion, x, y, facename, facespr, f, isfaceasset, facespriteoffset){
	switch facename {
		default:
			xoff += (58 * f)
			if isfaceasset {
				draw_sprite_stretched(facespr, emotion, x - 6*f, y - 3*f, 60*f, 60*f)
			} else draw_sprite_ext(facespr, emotion, x + facespriteoffset[0], y + facespriteoffset[1], f, f, 0, c_white, 1)
		break
		case "pinkspeaker_data":
			x += 359/2*f
			//show_debug_message(480 - y)
			y += 163/2*f
			y -= sprite_get_height(spr_pinkspeaker_silhouette) * f
			sprite_index = spr_pinkspeaker_silhouette
			var anim_spd = 1/5
			var playing = true
			
			var tailwag = false
			var crying = false
			var sweat = false
			var tail_index = scr_wrap(floor(timerdraw * anim_spd), 0, 11)

			var sweat_index = playing ? scr_wrap(floor(timerdraw * anim_spd), 0, 2) : 2
			var cry_index = scr_wrap(floor(timerdraw * anim_spd), 0, 2)
			var sprites = [
			/*0*/	[spr_pinkspeaker_silhouette, 0, false, false, -1, false], 
			/*1*/	[spr_pinkspeaker_talk, 0, true, false, -1, false], 
			/*2*/	[spr_pinkspeaker_concerned, 0, true, false, -1, false], 
			/*3*/	[spr_pinkspeaker_tongue, 0, false, false, -1, false], 
			/*4*/	[spr_pinkspeaker_nya, 1, false, false, -1, false], 
			/*5*/	[spr_pinkspeaker_nya2, 1, false, false, -1, false], 
			/*6*/	[spr_pinkspeaker_talk_happy, 16, true, false, -1, false], 
			/*7*/	[spr_pinkspeaker_angry, 0, false, false, -1, false], 
			/*8*/	[spr_pinkspeaker_wink, 0, true, false, -1, false], 
			/*9*/	[spr_pinkspeaker_cry, 0, false, true, -1, false], 
			/*10*/	[spr_pinkspeaker_sad, 0, false, false, spr_pinkspeaker_sad_end, false], 
			/*11*/	[spr_pinkspeaker_angry, 0, false, false, -1, true], 
			/*12*/	[spr_pinkspeaker_happytearful, 1, false, false, spr_pinkspeaker_happytearful_end, false], 
			/*13*/	[spr_pinkspeaker_happycry, 1, false, false, spr_pinkspeaker_happycry_end, false], 
			/*14*/	[spr_pinkspeaker_overjoyed, 0, false, true, -1, false], 
			/*15*/	[spr_pinkspeaker_shocked, 0, false, true, -1, false], 
			/*16*/	[spr_pinkspeaker_exploded, 0, false, false, -1, false], 
			/*17*/	[spr_pinkspeaker_angryblush, 0, false, false, -1, false],
			]
				
			var _flag = clamp(floor(emotion), 0, array_length(sprites) - 1)
				
			sprite_index = sprites[_flag][0]
			tailwag = sprites[_flag][2]
			crying = sprites[_flag][5]
				
			var _wave = 0
			var _xadj = 0
			image_xscale = f
			image_yscale = f

			if (sprite_index == spr_pinkspeaker_cry || sprite_index == spr_pinkspeaker_overjoyed){
				_wave = scr_wave(0, 10, 0.4, 0)
				image_xscale = (scr_wave(0, f, 1.5, 0) > 0.5*f) ? -f : f
				_xadj = (image_xscale < 0) ? abs(sprite_width) : 0
			}
				
			if (sprites[_flag][3] == false) {
				if (sprites[_flag][4] != -1) {
					sprite_index = sprites[_flag][4]
					playing = true
					image_speed = anim_spd
				} else {
					playing = false
					image_index = sprites[_flag][1]
					image_speed = 0
				}
			}
			else
			{
				if (playing == false) image_index = sprites[_flag][1]
			
				playing = true
				image_speed = anim_spd
			}
			
			if (tailwag) draw_sprite_ext(spr_pinkspeaker_tail, tail_index, x + f, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha)
	
			draw_sprite_ext(sprite_index, image_index, x + _xadj, y + _wave, image_xscale, image_yscale, image_angle, image_blend, image_alpha)
	
			if (sweat && sweat_index >= 0) draw_sprite_ext(spr_pinkspeaker_sweatdrop, sweat_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha)
	
			if (crying) draw_sprite_ext(spr_pinkspeaker_tears, cry_index, x - f, y + 20*f, image_xscale, image_yscale, image_angle, image_blend, image_alpha)
				
			
		break
	}
}