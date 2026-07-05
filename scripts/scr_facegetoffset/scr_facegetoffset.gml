// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_facegetoffset(facename, fixed = false){
	var fixeddarknermult = (fixed == true ? 0.5 : 1)
	try {
		switch facename {
			default:			return [0, 0]	
			
			case "susie_alt":	return [-5, 0]
			
			case "carol":		return [-9, -4]
			case "l0":
			case "r_hood": case "r_nohat": case "r_dark": return [-15 * fixeddarknermult, -10 * fixeddarknermult]
			
			case "n_matome_beach":
			case "rudy": case "n_matome": return [-12, -10]
			
			case "berdly":	case "berdly_dark":	
			case "catti": case "catty": case "jock":
			case "rurus":
			case "asgore_matome": case "asgore_matome_crown":
			case "alphys":	case "asgore":	case "undyne": return [-10 * (facename == "rusrus" ? fixeddarknermult : 1), 0]
			
			case "bratty": return [-5, 2]
			
			case "king": case "burgerpants": return [-5 * (facename=="king" ? fixeddarknermult : 1),-5 * (facename=="king" ? fixeddarknermult : 1)]
			case "flowery": return [8 * fixeddarknermult, 0]
			case "flowery_d": return [1 * fixeddarknermult, 6*fixeddarknermult]
		}
	} catch (ex) {}
	return [0, 0]
}