// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_facegetoffset(facename, fixed = false){
	try {
		switch facename {
			default:			return [0, 0]	
			
			case "susie_alt":	return [-5, 0]
			
			case "carol":		return [-9, -4]
			case "l0":
			case "r_hood": case "r_nohat": case "r_dark": return [-15 * (fixed == true ? 0.5 : 1), -10 * (fixed == true ? 0.5 : 1)]
			
			case "rudy": case "n_matome": return [-12, -10]
			
			case "berdly":	case "berdly_dark":	
			case "catti": case "catty": case "jock":
			case "rurus":
			case "alphys":	case "asgore":	case "undyne": return [-10 * (facename=="rurus"&&fixed == true ? 0.5 : 1), 0]
			
			case "bratty": return [-5, 2]
			
			case "king": case "burgerpants": return [-5 * (facename=="king"&&fixed == true ? 0.5 : 1),-5 * (facename=="king"&&fixed == true ? 0.5 : 1)]
		}
	} catch (ex) {}
	return [0, 0]
}